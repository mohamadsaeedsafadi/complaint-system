<?php
namespace App\Repositories;

use App\Models\Department;
use Illuminate\Support\Facades\Cache;
class DepartmentRepository
{
    public function create(array $data): Department
    {
        Cache::forget('departments_all');
        return Department::create($data);
    }
    public function getAll()
{
    return Cache::remember(
        'departments_all',
        now()->addHours(6),
        fn () => Department::select('id', 'name', 'code', 'description', 'created_at')->get()
    );
/*     return \App\Models\Department::select('id', 'name', 'code', 'description', 'created_at')->get();
 */}

}
