<?php

namespace App\Http\Controllers;

use App\Models\Complaint;
use App\Services\ComplaintMessageService;
use Illuminate\Http\Request;

class ComplaintMessageController extends Controller
{
    protected $service;

    public function __construct(ComplaintMessageService $service)
    {
        $this->service = $service;
    }

    public function requestMoreInfo(Request $request, $complaintId)
    {
        $request->validate([
            'message' => 'required|string',
            'attachment' => 'nullable|file|max:10240',
        ]);

        $complaint = Complaint::findOrFail($complaintId);

        try {
            $msg = $this->service->employeeRequest($request, $complaint);
        } catch (\Exception $e) {
            if ($e->getMessage() === 'unauthorized_employee') {
                return response()->json(['message'=>'غير مصرح لك'], 403);
            }
            throw $e;
        }

        return response()->json([
            'message' => 'تم إرسال طلب المعلومات الإضافية بنجاح.',
            'data' => $msg
        ]);
    }

    public function replyToRequest(Request $request, $complaintId)
    {
        $request->validate([
            'message' => 'required|string',
            'attachment' => 'nullable|file|max:10240',
        ]);

        $complaint = Complaint::findOrFail($complaintId);

        try {
            $msg = $this->service->citizenReply($request, $complaint);
        } catch (\Exception $e) {
            if ($e->getMessage() === 'unauthorized_citizen') {
                return response()->json(['message'=>'غير مصرح لك'], 403);
            }
            throw $e;
        }

        return response()->json([
            'message' => 'تم إرسال ردك بنجاح.',
            'data' => $msg
        ]);
    }

    public function getMessages($complaintId)
    {
        $messages = $this->service->getConversation($complaintId);

        return response()->json([
            'complaint_id' => $complaintId,
            'messages' => $messages
        ]);
    }
}
