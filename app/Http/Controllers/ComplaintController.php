<?php

namespace App\Http\Controllers;

use App\Models\Complaint;
use App\Services\ComplaintService;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class ComplaintController extends Controller
{
    protected  $service;

    public function __construct(ComplaintService $service)
    {
        $this->service = $service;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title'=>'required|string',
            'description'=>'nullable|string',
            'department_id'=>'nullable|exists:departments,id',
            'location'=>'nullable|string',
            'attachments.*'=>'file|max:10240' // 10MB
        ]);

        $complaint = $this->service->createComplaint($request, $data);

        return response()->json(['complaint'=>$complaint], 201);
    }

    public function assigned(Request $request)
    {
        $user = $request->user();
        $query = $this->service->getAssignedForEmployee($user->id);
        return $query->paginate(15);
    }

    public function departmentComplaints(Request $request)
    {
        $user = $request->user();
        if ($user->role !== 'employee') {
            return response()->json(['message' => 'غير مصرح بالدخول'], 403);
        }
        $query = $this->service->getForDepartment($user->department_id);
        return $query->paginate(15);
    }

    public function updateStatus(Request $request, $id)
{
    $request->validate([
        'status'=> ['required', Rule::in(['new','in_progress','resolved','rejected','closed'])],
        'note'=> 'nullable|string'
    ]);

    $complaint = Complaint::findOrFail($id);
    $user = $request->user();

    if ($user->role === 'employee') {
        $allowed = ($complaint->assigned_to == $user->id) 
                || ($complaint->department_id == $user->department_id);

        if (! $allowed) {
            return response()->json(['message'=>'غير مصرح بتغيير حالة هذه الشكوى'], 403);
        }
    }

    if (! $this->service->lockComplaint($complaint, $user)) {
        return response()->json([
            'message' => 'لا يمكن تعديل الشكوى لأنها قيد المعالجة من قبل موظف آخر'
        ], 423);
    }

    $updated = $this->service->updateStatus($complaint, $request->status, $request->note, $user);

   /*  $this->service->unlockComplaint($complaint, $user); */

    return response()->json(['complaint' => $updated]);
}


    public function myComplaints(Request $request)
    {
        return $request->user()->complaints()->with('department','assignedEmployee','attachments')->paginate(15);
    }

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


    public function assignComplaint(Request $request, $id)
    {
        $request->validate([
            'assigned_to' => 'required|exists:users,id'
        ]);

        $complaint = Complaint::findOrFail($id);

        try {
            $updated = $this->service->assignComplaint($request, $complaint, (int)$request->assigned_to);
        } catch (\InvalidArgumentException $e) {
            if ($e->getMessage() === 'target_not_employee') {
                return response()->json(['message'=>'المستخدم المحدد ليس موظفًا'], 422);
            }
            if ($e->getMessage() === 'different_department') {
                return response()->json(['message'=>'لا يمكن تعيين الشكوى لموظف من مؤسسة مختلفة'], 422);
            }
            throw $e;
        }

        return response()->json(['message' => 'تم تعيين الشكوى بنجاح', 'complaint' => $updated]);
    }

    
    public function trackByReference($reference_no)
    {
        $complaint = $this->service->trackByReference($reference_no);

        if (! $complaint) {
            return response()->json(['message' => 'لم يتم العثور على معاملة بهذا الرقم المرجعي'], 404);
        }

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
