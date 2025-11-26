<?php

namespace App\Services;

use App\Models\User;
use App\Repositories\NotificationRepository;

class InAppNotificationService
{
    public function __construct(
        protected NotificationRepository $repo
    ) {}

    public function notify(User $user, string $title, string $body = null, $relatedModel = null, $relatedId = null)
    {
        return $this->repo->create([
            'user_id' => $user->id,
            'title' => $title,
            'body' => $body,
            'related_model' => $relatedModel,
            'related_id' => $relatedId,
        ]);
    }

    public function getUserNotifications(User $user, $perPage = 15)
    {
        return $this->repo->getUserNotifications($user->id, $perPage);
    }

    public function markAsRead($notification)
    {
        return $this->repo->markAsRead($notification);
    }

    public function unreadCount(User $user)
    {
        return $this->repo->unreadCount($user->id);
    }
}
