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

    public function create(array $data): Complaint
    {
        return Complaint::create($data);
    }

    public function find(int $id): ?Complaint
    {
        return Complaint::find($id);
    }

    public function findByReference(string $ref): ?Complaint
    {
        return Complaint::where('reference_no', $ref)->first();
    }

    public function forAssignedEmployee(int $employeeId)
    {
        return Complaint::with('user','department','assignedEmployee','attachments')
            ->where('assigned_to', $employeeId)
            ->orderByDesc('created_at');
    }

    public function forDepartment(int $departmentId)
    {
        return Complaint::with('user','department','assignedEmployee','attachments')
            ->where('department_id', $departmentId)
            ->orderByDesc('created_at');
    }

    public function allQuery()
    {
        return Complaint::with('user','department','assignedEmployee','attachments')->orderByDesc('created_at');
    }

    public function countToday(): int
    {
        return Complaint::whereDate('created_at', now()->toDateString())->count();
    }

    public function update(Complaint $complaint, array $data): Complaint
    {
        $complaint->update($data);
        return $complaint->fresh();
    }
}

