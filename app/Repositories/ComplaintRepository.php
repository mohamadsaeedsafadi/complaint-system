<?php
namespace App\Repositories;

use App\Models\Complaint;

class ComplaintRepository
{
    public function countAll(): int
    {
        return Complaint::count();
    }

    public function countByStatus(string $status): int
    {
        return Complaint::where('status', $status)->count();
    }

    public function getAllForExport(): array
    {
        return Complaint::select('id','reference_no','title','status','created_at')->get()->toArray();
    }
}
