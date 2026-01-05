<?php

namespace App\Repositories;

use App\Models\ComplaintMessage;
use Illuminate\Support\Facades\Cache;

class ComplaintMessageRepository
{
    public function create(array $data): ComplaintMessage
    {
        Cache::forget('Message');
        return ComplaintMessage::create($data);
    }

    public function getConversation(int $complaintId)
    {
        return Cache::remember(
        'Message',
        now()->addHours(6),
        fn () =>ComplaintMessage::where('complaint_id', $complaintId)
            ->with('sender:id,name,role')
            ->orderBy('created_at')
            ->get() );
        
        
        /* ComplaintMessage::where('complaint_id', $complaintId)
            ->with('sender:id,name,role')
            ->orderBy('created_at')
            ->get(); */
    }
}
