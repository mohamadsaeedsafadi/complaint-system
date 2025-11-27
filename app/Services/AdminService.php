<?php

namespace App\Services;

use App\Repositories\UserRepository;
use App\Repositories\DepartmentRepository;
use App\Repositories\ActivityLogRepository;
use App\Repositories\ComplaintRepository;
use Barryvdh\DomPDF\Facade\Pdf as FacadePdf;
use Barryvdh\DomPDF\PDF as DomPDFPDF;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;
use League\Csv\Writer;
use SplTempFileObject;
use PDF;

class AdminService
{
    public function __construct(
        protected UserRepository $users,
        protected DepartmentRepository $departments,
        protected ComplaintRepository $complaints,
        protected ActivityLogRepository $logs
    ) {}

    protected function logAction(string $action, array $details = [], ?int $userId = null)
{
    $this->logs->create([
        'user_id' => $userId,
        'action' => $action,
        'route' => request()->path(),
        'method' => request()->method(),
        'ip' => request()->ip(),
        'request_payload' => $details,
        'response_status' => 200,
    ]);
}


    
    public function createEmployee(array $data)
{
    $data['role'] = 'employee';
    $data['password'] = Hash::make($data['password']);

    $employee = $this->users->create($data);

    $this->logAction('create_employee', ['employee_id' => $employee->id]);

    return $employee;
}


    
    public function updateEmployee($employee, array $data)
{
    $employee->update($data);

    $this->logAction('update_employee', ['employee_id' => $employee->id]);

    return $employee;
}


    
    public function deleteEmployee($employee)
{
    $this->users->delete($employee);

    $this->logAction('delete_employee', ['employee_id' => $employee->id]);

    return true;
}


    
    public function createDepartment(array $data)
{
    $department = $this->departments->create($data);

    $this->logAction('create_department', ['department_id' => $department->id]);

    return $department;
}


    
    public function createAdmin(array $data)
{
    $data['role'] = 'admin';
    $data['password'] = Hash::make($data['password']);

    $admin = $this->users->create($data);

    $this->logAction('create_admin', ['admin_id' => $admin->id]);

    return $admin;
}

    
   public function getSystemOverview(): array
{
    $this->logAction('view_system_overview');

    return [
        'total_users' => $this->users->countAll(),
        'admins' => $this->users->countByRole('admin'),
        'employees' => $this->users->countByRole('employee'),
        'complaints' => $this->complaints->countAll(),
        'complaints_new' => $this->complaints->countByStatus('new'),
        'complaints_closed' => $this->complaints->countByStatus('closed'),
        'logs' => $this->logs->countAll(),
    ];
}


    
    public function getActivityLogs(int $perPage = 20)
    {
        return $this->logs->getAllWithUsers($perPage);
    }

    
    public function exportCsv(string $type): string
    {
                $this->logAction('export_csv', ['type' => $type]);
        $data = $this->getDataForExport($type);
        if (empty($data)) return '';

        $csv = Writer::createFromFileObject(new SplTempFileObject());
        $csv->insertOne(array_keys($data[0]));
        foreach ($data as $row) $csv->insertOne($row);

        $filename = "reports/{$type}-" . now()->format('Ymd_His') . ".csv";
        Storage::disk('public')->put($filename, $csv->toString());
        return Storage::url($filename);
    }

    
    public function exportPdf(string $type): string
    {
            $this->logAction('export_pdf', ['type' => $type]);
        $data = $this->getDataForExport($type);
        if (empty($data)) return '';

        $pdf = FacadePdf::loadView('reports.generic', [
            'data' => $data,
            'type' => $type,
        ]);

        $filename = "reports/{$type}-" . now()->format('Ymd_His') . ".pdf";
        Storage::disk('public')->put($filename, $pdf->output());
        return Storage::url($filename);
    }

    protected function getDataForExport(string $type): array
    {
        return match ($type) {
            'users' => $this->users->getAllForExport(),
            'complaints' => $this->complaints->getAllForExport(),
            'logs' => $this->logs->getAllForExport(),
            default => [],
        };
    }
  public function listDepartments()
{
    $this->logAction('list_departments');
    return $this->departments->getAll();
}


public function listEmployees()
{
    $this->logAction('list_employees');
    return $this->users->getEmployees();
}


}
