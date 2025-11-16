<?php
namespace App\Repositories;

use App\Models\ActivityLog;

class ActivityLogRepository
{
    public function create(array $data): ActivityLog
    {
        return ActivityLog::create($data);
    }

     public function countAll(): int
    {
        return ActivityLog::count();
    }

    public function getAllWithUsers(int $perPage = 20)
    {
        return ActivityLog::with('user:id,name,role')->latest()->paginate($perPage);
    }

    public function getAllForExport(): array
    {
        return ActivityLog::select('id','user_id','action','route','method','duration_ms','created_at')->get()->toArray();
    }
}
