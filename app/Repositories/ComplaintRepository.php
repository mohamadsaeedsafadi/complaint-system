<?php
namespace App\Repositories;

use App\Models\Complaint;
use Illuminate\Support\Facades\Cache;

class ComplaintRepository
{
    public function countAll(): int
    {
        return Cache::remember(
        'Complaint',
        now()->addHours(6),
        fn () =>Complaint::count() );
        /* Complaint::count() */
    }

    public function countByStatus(string $status): int
    {
        return Cache::remember(
        'Complaint',
        now()->addHours(6),
        fn () =>Complaint::where('status', $status)->count());
    }
    public function getAllForExport(): array
    {
        return Cache::remember(
        'Complaint',
        now()->addHours(6),
        fn () =>Complaint::select('id','reference_no','title','status','created_at')->get()->toArray());
    }

    public function create(array $data): Complaint
    {
        Cache::forget('Complaint');
        return Complaint::create($data);
    }

    public function find(int $id): ?Complaint
    {
        return Cache::remember(
        'Complaint',
        now()->addHours(6),
        fn () =>
         Complaint::find($id));
    }

    public function findByReference(string $ref): ?Complaint
    {
        return Cache::remember(
        'Complaint',
        now()->addHours(6),
        fn () =>Complaint::where('reference_no', $ref)->first());
    }

    public function forAssignedEmployee(int $employeeId)
    {
        return Cache::remember(
        'Complaint',
        now()->addHours(6),
        fn () =>Complaint::with('user','department','assignedEmployee','attachments')
            ->where('assigned_to', $employeeId)
            ->orderByDesc('created_at'));
    }

    public function forDepartment(int $departmentId)
    {
        return Cache::remember(
        'Complaint',
        now()->addHours(6),
        fn () =>Complaint::with('user','department','assignedEmployee','attachments')
            ->where('department_id', $departmentId)
            ->orderByDesc('created_at'));
    }

    public function allQuery()
    {
        return Cache::remember(
        'Complaint',
        now()->addHours(6),
        fn () =>Complaint::with('user','department','assignedEmployee','attachments')->orderByDesc('created_at'));
    }

    public function countToday(): int
    {
        return Cache::remember(
        'Complaint',
        now()->addHours(6),
        fn () =>Complaint::whereDate('created_at', now()->toDateString())->count());
    }

    public function update(Complaint $complaint, array $data): Complaint
    {
                Cache::forget('Complaint');
        $complaint->update($data);
        return $complaint->fresh();
    }
}

