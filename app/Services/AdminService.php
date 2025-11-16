<?php

namespace App\Services;

use App\Repositories\UserRepository;
use App\Repositories\DepartmentRepository;
use App\Repositories\ComplaintRepository;
use App\Repositories\ActivityLogRepository;
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

    
    public function createEmployee(array $data)
    {
        $data['role'] = 'employee';
        $data['password'] = Hash::make($data['password']);
        return $this->users->create($data);
    }

    
    public function updateEmployee($employee, array $data)
    {
        $employee->update($data);
        return $employee;
    }

    
    public function deleteEmployee($employee)
    {
        return $this->users->delete($employee);
    }

    
    public function createDepartment(array $data)
    {
        return $this->departments->create($data);
    }

    
    public function createAdmin(array $data)
    {
        $data['role'] = 'admin';
        $data['password'] = Hash::make($data['password']);
        return $this->users->create($data);
    }

    
    public function getSystemOverview(): array
    {
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
}
