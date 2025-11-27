<?php

namespace App\Services;

use App\Repositories\ComplaintMessageRepository;
use App\Models\Complaint;
use App\Models\ActivityLog;
use App\Repositories\ComplaintRepository;
use Illuminate\Http\Request;

class ComplaintMessageService
{
    public function __construct(
        protected ComplaintMessageRepository $repo ,
        protected ComplaintRepository $complaints,
    protected InAppNotificationService $inAppNotifier 
    ) {}

    public function employeeRequest(Request $request, Complaint $complaint)
    {
        $user = $request->user();

        if ($user->role !== 'employee' || $user->department_id !== $complaint->department_id) {
            throw new \Exception("unauthorized_employee");
        }

        $path = null;
        $name = null;

        if ($request->hasFile('attachment')) {
            $path = $request->file('attachment')->store('complaint_messages', 'public');
            $name = $request->file('attachment')->getClientOriginalName();
        }

        $msg = $this->repo->create([
            'complaint_id' => $complaint->id,
            'sender_id' => $user->id,
            'message' => $request->message,
            'attachment_path' => $path,
            'attachment_name' => $name,
            'type' => 'employee_request'
        ]);

        ActivityLog::create([
            'user_id' => $user->id,
            'action' => 'employee_request_more_info',
            'route' => $request->path(),
            'method' => $request->method(),
            'ip' => $request->ip(),
            'request_payload' => ['complaint_id'=>$complaint->id, 'message'=>$request->message],
            'response_status' => 200
        ]);

        $this->inAppNotifier->notify(
    $complaint->user,
    "طلب معلومات إضافية",
    "يرجى تزويدنا بمعلومات إضافية للشكوى رقم {$complaint->reference_no}",
    Complaint::class,
    $complaint->id
);

        return $msg;
    }

    public function citizenReply(Request $request, Complaint $complaint)
    {
        $user = $request->user();

        if ($complaint->user_id !== $user->id) {
            throw new \Exception("unauthorized_citizen");
        }

        $path = null;
        $name = null;

        if ($request->hasFile('attachment')) {
            $path = $request->file('attachment')->store('complaint_messages', 'public');
            $name = $request->file('attachment')->getClientOriginalName();
        }

        $msg = $this->repo->create([
            'complaint_id' => $complaint->id,
            'sender_id' => $user->id,
            'message' => $request->message,
            'attachment_path' => $path,
            'attachment_name' => $name,
            'type' => 'citizen_reply'
        ]);

        ActivityLog::create([
            'user_id' => $user->id,
            'action' => 'citizen_reply',
            'route' => $request->path(),
            'method' => $request->method(),
            'ip' => $request->ip(),
            'request_payload' => ['complaint_id'=>$complaint->id, 'message'=>$request->message],
            'response_status' => 200
        ]);

        return $msg;
    }

    public function getConversation(int $complaintId)
    {
        return $this->repo->getConversation($complaintId);
    }
}
