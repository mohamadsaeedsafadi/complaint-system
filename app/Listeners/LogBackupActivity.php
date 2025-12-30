<?php

namespace App\Listeners;

use App\Events\BackupCreated;
use App\Models\ActivityLog;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

class LogBackupActivity
{
    /**
     * Create the event listener.
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     */
      public function handle(BackupCreated $event)
    {
        ActivityLog::create([
            'user_id' => null,
            'action' => 'database_backup',
            'route' => 'system',
            'method' => 'cron',
            'ip' => request()->ip(),
            'request_payload' => [
                'file' => $event->backup->file_name
            ],
            'response_status' => $event->backup->status === 'success' ? 200 : 500
        ]);
    }
}
