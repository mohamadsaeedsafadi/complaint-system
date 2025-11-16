<?php

namespace App\Http\Controllers;

use App\Models\Complaint;
use App\Models\ComplaintStatusHistory;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;

class ComplaintController extends Controller
{
    // مواطن يرفع شكوى
    public function store(Request $request)
    {
        $data = $request->validate([
            'title'=>'required|string',
            'description'=>'nullable|string',
            'department_id'=>'nullable|exists:departments,id',
            'location'=>'nullable|string',
            'attachments.*'=>'file|max:10240' // 10MB
        ]);

        // توليد رقم مرجعي فريد: CMP-YYYYMMDD-XXXX
        $countToday = Complaint::whereDate('created_at', now()->toDateString())->count() + 1;
        $ref = sprintf('CMP-%s-%04d', now()->format('Ymd'), $countToday);

        $complaint = Complaint::create(array_merge($data, [
            'user_id'=> $request->user()->id,
            'reference_no'=> $ref,
            'status'=>'new'
        ]));

        // حفظ المرفقات (إذا وُجدت)
        if ($request->hasFile('attachments')) {
            foreach ($request->file('attachments') as $file) {
                $path = $file->store('complaint_attachments','public'); // storage/app/public
                $complaint->attachments()->create([
                    'storage_path'=>$path,
                    'original_name'=>$file->getClientOriginalName(),
                    'mime_type'=>$file->getClientMimeType(),
                    'size'=>$file->getSize(),
                    'uploaded_by'=>$request->user()->id,
                ]);
            }
        }

        return response()->json(['complaint'=>$complaint], 201);
    }

    // موظف يرى الشكاوى المعينة له
    public function assigned(Request $request)
    {
      

    // الشكاوى التي تم تعيينها لهذا الموظف (assigned_to = user.id)
    $user = $request->user();

    return \App\Models\Complaint::with('user','department','assignedEmployee','attachments')
        ->where('assigned_to', $user->id)
        ->orderByDesc('created_at')
        ->paginate(15);


    }

    public function departmentComplaints(Request $request)
{
    $user = $request->user();

    // تحقق دور الموظف
    if ($user->role !== 'employee') {
        return response()->json(['message' => 'غير مصرح بالدخول'], 403);
    }

    return \App\Models\Complaint::with('user','department','assignedEmployee','attachments')
        ->where('department_id', $user->department_id)
        ->orderByDesc('created_at')
        ->paginate(15);
}


    // موظف أو أدمن يغيّر الحالة (مع حفظ السجل)
    public function updateStatus(Request $request, $id)
    {
        $request->validate([
            'status'=> ['required', Rule::in(['new','in_progress','resolved','rejected','closed'])],
            'note'=> 'nullable|string'
        ]);

        $complaint = Complaint::findOrFail($id);

        // صلاحية التغيير: إما admin أو الموظف المعين أو موظف بنفس department
        $user = $request->user();
        if ($user->role === 'employee') {
            $allowed = ($complaint->assigned_to == $user->id) || ($complaint->department_id == $user->department_id);
            if (! $allowed) {
                return response()->json(['message'=>'غير مصرح بتغيير حالة هذه الشكوى'], 403);
            }
        }

        $from = $complaint->status;
        $complaint->status = $request->status;
        $complaint->save();

        ComplaintStatusHistory::create([
            'complaint_id'=>$complaint->id,
            'from_status'=>$from,
            'to_status'=>$request->status,
            'changed_by'=>$user->id,
            'note'=>$request->note
        ]);

        return response()->json(['complaint'=>$complaint]);
    }

    // مواطن يرى شكاويه
    public function myComplaints(Request $request)
    {
        return $request->user()->complaints()->with('department','assignedEmployee','attachments')->paginate(15);
    }

    // أدمن يرى كل الشكاوى (مع فلترة بسيطة)
    public function allComplaints(Request $request)
    {
        $q = Complaint::query()->with('user','department','assignedEmployee','attachments');

        if ($request->filled('status')) {
            $q->where('status',$request->status);
        }
        if ($request->filled('department_id')) {
            $q->where('department_id',$request->department_id);
        }

        return $q->paginate(20);
    }


    // أدمن يعيّن شكوى لموظف (يجب أن يكون الموظف من نفس المؤسسة)
public function assignComplaint(Request $request, $id)
{
    $request->validate([
        'assigned_to' => 'required|exists:users,id'
    ]);

    $complaint = Complaint::findOrFail($id);
    $employee = \App\Models\User::findOrFail($request->assigned_to);

    // تحقق من أن المستهدف موظف
    if ($employee->role !== 'employee') {
        return response()->json(['message' => 'المستخدم المحدد ليس موظفًا'], 422);
    }

    // تحقق من نفس المؤسسة (لا تسمح بتعيين موظف من مؤسسة أخرى)
    if ($employee->department_id !== $complaint->department_id) {
        return response()->json(['message' => 'لا يمكن تعيين الشكوى لموظف من مؤسسة مختلفة'], 422);
    }

    $complaint->assigned_to = $employee->id;
    $complaint->save();

    // سجل النشاط (اختياري) — سجل assignment في history
    \App\Models\ComplaintStatusHistory::create([
        'complaint_id' => $complaint->id,
        'from_status' => $complaint->status,
        'to_status' => $complaint->status,
        'changed_by' => $request->user()->id,
        'note' => "تعيين الشكوى إلى الموظف: {$employee->id}"
    ]);

    // سجل في ActivityLog (اختياري)
    \App\Models\ActivityLog::create([
        'user_id' => $request->user()->id,
        'action' => 'assign_complaint',
        'model_type' => \App\Models\Complaint::class,
        'model_id' => $complaint->id,
        'old_values' => null,
        'new_values' => ['assigned_to' => $employee->id],
    ]);

    return response()->json(['message' => 'تم تعيين الشكوى بنجاح', 'complaint' => $complaint]);
}


public function trackByReference($reference_no)
{
    $complaint = \App\Models\Complaint::with([
        'user:id,name,phone',
        'department:id,name',
        'assignedEmployee:id,name,phone',
        'attachments:id,complaint_id,original_name,storage_path'
    ])->where('reference_no', $reference_no)->first();

    if (! $complaint) {
        return response()->json([
            'message' => 'لم يتم العثور على معاملة بهذا الرقم المرجعي'
        ], 404);
    }

    // أضف رابط كامل لكل مرفق
    $complaint->attachments->transform(function ($attachment) {
        $attachment->url = asset('storage/' . $attachment->storage_path);
        return $attachment;
    });

    return response()->json([
        'reference_no' => $complaint->reference_no,
        'status' => $complaint->status,
        'title' => $complaint->title,
        'department' => $complaint->department?->name,
        'citizen' => $complaint->user?->name,
        'assigned_employee' => $complaint->assignedEmployee?->name,
        'created_at' => $complaint->created_at->format('Y-m-d H:i'),
        'attachments' => $complaint->attachments,
        'description' => $complaint->description,
    ]);
}

}

