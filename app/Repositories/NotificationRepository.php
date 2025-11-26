<?php

namespace App\Repositories;

use App\Models\Notification;

class NotificationRepository
{
    public function create(array $data): Notification
    {
        return Notification::create($data);
    }

    public function getUserNotifications(int $userId, $perPage = 15)
    {
        return Notification::where('user_id', $userId)
            ->latest()
            ->paginate($perPage);
    }

    public function markAsRead(Notification $notification)
    {
        $notification->is_read = true;
        $notification->save();
        return $notification;
    }

    public function unreadCount(int $userId)
    {
        return Notification::where('user_id', $userId)
            ->where('is_read', false)
            ->count();
    }
}
