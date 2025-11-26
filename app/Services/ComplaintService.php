<?php
namespace App\Services;

use App\Repositories\ComplaintRepository;
use App\Models\Complaint;
use App\Models\ComplaintStatusHistory;
use App\Models\ActivityLog;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Arr;

class ComplaintService
{
    
    public function __construct(protected ComplaintRepository $repo ,  protected ComplaintRepository $complaints,
    protected InAppNotificationService $inAppNotifier ) {
    }

    public function createComplaint(Request $request, array $data): Complaint
    {
        $countToday = $this->repo->countToday() + 1;
        $ref = sprintf('CMP-%s-%04d', now()->format('Ymd'), $countToday);

        $payload = array_merge($data, [
            'user_id' => $request->user()->id,
            'reference_no' => $ref,
            'status' => 'new'
        ]);

        $complaint = $this->repo->create($payload);

        if ($request->hasFile('attachments')) {
            foreach ($request->file('attachments') as $file) {
                $path = $file->store('complaint_attachments','public');
                $complaint->attachments()->create([
                    'storage_path' => $path,
                    'original_name' => $file->getClientOriginalName(),
                    'mime_type' => $file->getClientMimeType(),
                    'size' => $file->getSize(),
                    'uploaded_by' => $request->user()->id,
                ]);
            }
        }

        ActivityLog::create([
            'user_id' => $request->user()->id,
            'action' => 'create_complaint',
            'route' => $request->path(),
            'method' => $request->method(),
            'ip' => $request->ip(),
            'request_payload' => $this->sanitizeForLog($payload),
            'response_status' => 201,
            'duration_ms' => null,
        ]);

        return $complaint->fresh();
    }

    public function getAssignedForEmployee(int $employeeId)
    {
        return $this->repo->forAssignedEmployee($employeeId);
    }

    public function getForDepartment(int $departmentId)
    {
        return $this->repo->forDepartment($departmentId);
    }

    public function updateStatus(Complaint $complaint, string $newStatus, ?string $note, User $user)
{
    $from = $complaint->status;

    $complaint->status = $newStatus;
    $complaint->save();

    ComplaintStatusHistory::create([
        'complaint_id' => $complaint->id,
        'from_status' => $from,
        'to_status' => $newStatus,
        'changed_by' => $user->id,
        'note' => $note
    ]);
    
    $this->inAppNotifier->notify(
    $complaint->user,
    "تغيير حالة الشكوى",
    "تم تغيير حالة شكواك رقم {$complaint->reference_no} إلى {$newStatus}",
    Complaint::class,
    $complaint->id
);


        return $complaint->fresh();
    }

    public function assignComplaint(Request $request, Complaint $complaint, int $employeeId)
    {
        $employee = \App\Models\User::findOrFail($employeeId);

        if ($employee->role !== 'employee') {
            throw new \InvalidArgumentException('target_not_employee');
        }
        if ($employee->department_id !== $complaint->department_id) {
            throw new \InvalidArgumentException('different_department');
        }

        $old = $complaint->assigned_to;
        $complaint->assigned_to = $employee->id;
        $complaint->save();

        ComplaintStatusHistory::create([
            'complaint_id' => $complaint->id,
            'from_status' => $complaint->status,
            'to_status' => $complaint->status,
            'changed_by' => $request->user()->id,
            'note' => "assigned_to: {$employee->id}"
        ]);

        ActivityLog::create([
            'user_id' => $request->user()->id,
            'action' => 'assign_complaint',
            'route' => $request->path(),
            'method' => $request->method(),
            'ip' => $request->ip(),
            'request_payload' => ['old_assigned'=>$old,'new_assigned'=>$employee->id,'complaint_id'=>$complaint->id],
            'response_status' => 200,
            'duration_ms' => null,
        ]);

        return $complaint->fresh();
    }

    public function trackByReference(string $ref)
    {
        return $this->repo->findByReference($ref);
    }

    protected function sanitizeForLog(array $payload): array
    {
        return Arr::except($payload, ['password']);
    }

    public function lockComplaint(Complaint $complaint, User $user)
{
    if ($complaint->locked_by 
        && $complaint->locked_by != $user->id 
        && $complaint->locked_at 
        && $complaint->locked_at->diffInMinutes(now()) < 5) {

        return false; 
    }

    $complaint->locked_by = $user->id;
    $complaint->locked_at = now();
    $complaint->save();

    return true;
}

public function unlockComplaint(Complaint $complaint, User $user)
{
    if ($complaint->locked_by == $user->id) {
        $complaint->locked_by = null;
        $complaint->locked_at = null;
        $complaint->save();
    }
}

}
