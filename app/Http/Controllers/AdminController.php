<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\Models\User;
use App\Services\AdminService;

class AdminController extends Controller
{
    protected AdminService $admin;

    public function __construct(AdminService $admin)
    {
        $this->admin = $admin;
    }

    public function createEmployee(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'nullable|email|unique:users',
            'phone' => 'required|string|unique:users,phone',
            'password' => 'required|string|min:6',
            'department_id' => 'required|exists:departments,id',
        ]);

        $employee = $this->admin->createEmployee($data);
        return response()->json(['employee' => $employee], 201);
    }

    public function updateEmployee(Request $request, $id)
    {
        $employee = User::where('role', 'employee')->findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'email' => ['sometimes','string', Rule::unique('users','email')->ignore($employee->id)],
            'phone' => ['sometimes','string', Rule::unique('users','phone')->ignore($employee->id)],
            'department_id' => 'sometimes|exists:departments,id',
        ]);

        $updated = $this->admin->updateEmployee($employee, $validated);
        return response()->json(['employee' => $updated]);
    }

    public function deleteEmployee($id)
    {
        $employee = User::where('role', 'employee')->findOrFail($id);
        $this->admin->deleteEmployee($employee);

        return response()->json(['message' => 'تم حذف الموظف بنجاح']);
    }

    public function createDepartment(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255|unique:departments,name',
            'code' => 'nullable|string|max:50|unique:departments,code',
            'description' => 'nullable|string',
        ]);

        $department = $this->admin->createDepartment($data);
        return response()->json(['message' => 'تمت إضافة المؤسسة بنجاح', 'department' => $department], 201);
    }

    public function createAdmin(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|unique:users,email',
            'phone' => 'required|string|unique:users,phone',
            'password' => 'required|string|min:6',
        ]);

        $admin = $this->admin->createAdmin($data);
        return response()->json(['message' => 'تمت إضافة الأدمن الجديد بنجاح', 'admin' => $admin], 201);
    }

    public function dashboard()
    {
        $overview = $this->admin->getSystemOverview();
        return response()->json($overview);
    }

    public function activityLogs(Request $request)
    {
        $logs = $this->admin->getActivityLogs($request->get('per_page', 20));
        return response()->json($logs);
    }

    public function exportCsv(Request $request)
    {
        $request->validate(['type' => 'required|in:users,complaints,logs']);
        $url = $this->admin->exportCsv($request->type);
        return response()->json(['file_url' => $url]);
    }

    public function exportPdf(Request $request)
    {
        $request->validate(['type' => 'required|in:users,complaints,logs']);
        $url = $this->admin->exportPdf($request->type);
        return response()->json(['file_url' => $url]);
    }
}
