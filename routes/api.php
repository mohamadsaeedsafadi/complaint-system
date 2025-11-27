<?php

use App\Http\Controllers\AdminController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ComplaintController;
use App\Http\Controllers\EmployeeVerificationController;
use App\Http\Controllers\NotificationController;

Route::post('/register', [AuthController::class,'register']);
Route::post('/login', [AuthController::class,'login']);
Route::post('/send-otp', [\App\Http\Controllers\AuthController::class, 'sendOtp']);
Route::post('/verify-otp', [\App\Http\Controllers\AuthController::class, 'verifyOtp']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/complaints/{id}/request-info', [\App\Http\Controllers\ComplaintMessageController::class, 'requestMoreInfo'])
        ->middleware('role:employee');
    
    Route::post('/complaints/{id}/reply', [\App\Http\Controllers\ComplaintMessageController::class, 'replyToRequest'])
        ->middleware('role:citizen');

    Route::get('/complaints/{id}/messages', [\App\Http\Controllers\ComplaintMessageController::class, 'getMessages']);
});




Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class,'logout']);

    
    Route::middleware('role:citizen')->group(function () {
        Route::post('/complaints', [ComplaintController::class,'store']);
        Route::get('/my-complaints', [ComplaintController::class,'myComplaints']);
        Route::get('/track/{reference_no}', [\App\Http\Controllers\ComplaintController::class, 'trackByReference']);
    });

Route::middleware(['auth:sanctum','role:employee'])->group(function () {
    Route::get('/assigned-complaints', [\App\Http\Controllers\ComplaintController::class, 'assigned']);
    Route::get('/department-complaints', [\App\Http\Controllers\ComplaintController::class, 'departmentComplaints']);
    Route::patch('/updateStatus/{id}', [\App\Http\Controllers\ComplaintController::class, 'updateStatus']);
    
});

Route::middleware(['auth:sanctum','role:admin'])->group(function () {
    Route::post('/admin/employees', [\App\Http\Controllers\AdminController::class, 'createEmployee']);
    Route::patch('/admin/employees/{id}', [\App\Http\Controllers\AdminController::class, 'updateEmployee']);
    Route::delete('/admin/employees/{id}', [\App\Http\Controllers\AdminController::class, 'deleteEmployee']);
    Route::post('/admin/complaints/{id}/assign', [\App\Http\Controllers\ComplaintController::class, 'assignComplaint']);
    Route::post('/admin/departments', [\App\Http\Controllers\AdminController::class, 'createDepartment']);
    Route::post('/admin/add-admin', [\App\Http\Controllers\AdminController::class, 'createAdmin']);
    Route::get('/admin/viewcom', [\App\Http\Controllers\ComplaintController::class, 'allComplaints']);
Route::get('/admin/dashboard', [AdminController::class, 'dashboard']);
    Route::get('/admin/logs', [AdminController::class, 'activityLogs']);

    Route::get('/admin/export/csv', [AdminController::class, 'exportCsv']);
    Route::get('/admin/export/pdf', [AdminController::class, 'exportPdf']);
    
});
});

Route::middleware('auth:sanctum')->group(function () {
    
    Route::get('/notifications', [NotificationController::class, 'index']);
    Route::get('/notifications/unread-count', [NotificationController::class, 'unreadCount']);
    Route::patch('/notifications/{id}/read', [NotificationController::class, 'markAsRead']);
});

Route::middleware(['auth:sanctum', 'role:admin'])->group(function () {

    Route::get('/admin/departments', [AdminController::class, 'listDepartments']);
    Route::get('/admin/employees', [AdminController::class, 'listEmployees']);

});


    Route::post('/sendotpforemp', [AuthController::class, 'employeeSendOtp']);





