<?php

namespace App\Services;

use App\Models\ActivityLog;

class ActivityLoggerService
{
    public function log(int $userId, string $action, array $details = [])
    {
        ActivityLog::create([
            'user_id' => $userId,
            'action' => $action,
            'route' => $details['route'] ?? null,
            'method' => $details['method'] ?? null,
            'ip' => $details['ip'] ?? null,
            'request_payload' => $details['request_payload'] ?? null,
            'response_status' => $details['response_status'] ?? 200,
            'duration_ms' => $details['duration_ms'] ?? null,
        ]);
    }
}
