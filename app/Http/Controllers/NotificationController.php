<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use App\Services\InAppNotificationService;
use Illuminate\Http\Request;

class NotificationController extends Controller
{
    public function __construct(
        protected InAppNotificationService $service
    ) {}

    public function index(Request $request)
    {
        return $this->service->getUserNotifications($request->user());
    }

    public function unreadCount(Request $request)
    {
        return [
            'unread' => $this->service->unreadCount($request->user())
        ];
    }

    public function markAsRead(Request $request, $id)
    {
        $notification = Notification::where('user_id', $request->user()->id)->findOrFail($id);

        return $this->service->markAsRead($notification);
    }
}
