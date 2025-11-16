<?php
namespace App\Repositories;

use App\Models\Department;

class DepartmentRepository
{
    public function create(array $data): Department
    {
        return Department::create($data);
    }
}
