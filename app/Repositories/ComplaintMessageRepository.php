<?php

namespace App\Repositories;

use App\Models\ComplaintMessage;

class ComplaintMessageRepository
{
    public function create(array $data): ComplaintMessage
    {
        return ComplaintMessage::create($data);
    }

    public function getConversation(int $complaintId)
    {
        return ComplaintMessage::where('complaint_id', $complaintId)
            ->with('sender:id,name,role')
            ->orderBy('created_at')
            ->get();
    }
}
