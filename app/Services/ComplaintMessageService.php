<?php

namespace App\Services;

use App\Repositories\ComplaintMessageRepository;
use App\Models\Complaint;
use App\Models\ActivityLog;
use Illuminate\Http\Request;

class ComplaintMessageService
{
    public function __construct(
        protected ComplaintMessageRepository $repo
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

        // AOP - Activity Log
        ActivityLog::create([
            'user_id' => $user->id,
            'action' => 'employee_request_more_info',
            'route' => $request->path(),
            'method' => $request->method(),
            'ip' => $request->ip(),
            'request_payload' => ['complaint_id'=>$complaint->id, 'message'=>$request->message],
            'response_status' => 200
        ]);

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
