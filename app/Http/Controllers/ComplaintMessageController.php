<?php

namespace App\Http\Controllers;

use App\Models\Complaint;
use App\Models\ComplaintMessage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ComplaintMessageController extends Controller
{
    // 🟢 الموظف يرسل طلب معلومات إضافية
    public function requestMoreInfo(Request $request, $complaintId)
    {
        $request->validate([
            'message' => 'required|string',
            'attachment' => 'nullable|file|max:10240',
        ]);

        $complaint = Complaint::findOrFail($complaintId);
        $user = $request->user();

        // تحقق أن الموظف تابع لنفس المؤسسة
        if ($user->role !== 'employee' || $user->department_id !== $complaint->department_id) {
            return response()->json(['message' => 'غير مصرح لك بطلب معلومات لهذه الشكوى.'], 403);
        }

        $path = null;
        $name = null;
        if ($request->hasFile('attachment')) {
            $path = $request->file('attachment')->store('complaint_messages', 'public');
            $name = $request->file('attachment')->getClientOriginalName();
        }

        $msg = ComplaintMessage::create([
            'complaint_id' => $complaint->id,
            'sender_id' => $user->id,
            'message' => $request->message,
            'attachment_path' => $path,
            'attachment_name' => $name,
            'type' => 'employee_request'
        ]);

        return response()->json([
            'message' => 'تم إرسال طلب المعلومات الإضافية بنجاح.',
            'data' => $msg
        ]);
    }

    // 🟢 المواطن يرد على الطلب
    public function replyToRequest(Request $request, $complaintId)
    {
        $request->validate([
            'message' => 'required|string',
            'attachment' => 'nullable|file|max:10240',
        ]);

        $complaint = Complaint::findOrFail($complaintId);
        $user = $request->user();

        if ($user->id !== $complaint->user_id) {
            return response()->json(['message' => 'غير مصرح لك بالرد على هذه الشكوى.'], 403);
        }

        $path = null;
        $name = null;
        if ($request->hasFile('attachment')) {
            $path = $request->file('attachment')->store('complaint_messages', 'public');
            $name = $request->file('attachment')->getClientOriginalName();
        }

        $msg = ComplaintMessage::create([
            'complaint_id' => $complaint->id,
            'sender_id' => $user->id,
            'message' => $request->message,
            'attachment_path' => $path,
            'attachment_name' => $name,
            'type' => 'citizen_reply'
        ]);

        return response()->json([
            'message' => 'تم إرسال ردك بنجاح.',
            'data' => $msg
        ]);
    }

    // 🔹 عرض المحادثة الكاملة للشكوى
    public function getMessages($complaintId)
    {
        $complaint = Complaint::with('messages.sender:id,name,role')->findOrFail($complaintId);

        return response()->json([
            'complaint' => $complaint->reference_no,
            'messages' => $complaint->messages()->orderBy('created_at')->get(),
        ]);
    }
}
