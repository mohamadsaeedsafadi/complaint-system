<?php

namespace App\Http\Controllers;

use App\Services\AuthService;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function __construct(
        protected AuthService $auth,
    ) {}

    public function register(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'email' => 'nullable|email|unique:users',
            'phone' => 'required|unique:users',
            'password' => 'required|min:6',
            'role' => 'in:citizen,admin',
        ]);

        $user = $this->auth->register($data);

        return response()->json([
            'message' => 'تم إنشاء الحساب بنجاح، يرجى اختيار طريقة التحقق (email أو whatsapp).',
            'user_id' => $user->id,
        ], 201);
    }

    public function sendOtp(Request $request)
    {
        $data = $request->validate([
            'user_id' => 'required|exists:users,id',
            'method' => 'required|in:email,whatsapp',
        ]);

        $result = $this->auth->sendOtpByUserId($data['user_id'], $data['method']);

        return response()->json($result);
    }


    public function verifyOtp(Request $request)
    {
        $data = $request->validate([
            'user_id' => 'required|exists:users,id',
            'code' => 'required|string',
        ]);

        $verified = $this->auth->verifyOtp($data['user_id'], $data['code']);
        if (! $verified) {
            return response()->json(['message' => 'رمز التحقق غير صالح أو منتهي الصلاحية.'], 403);
        }

        return response()->json(['message' => 'تم التحقق بنجاح، يمكنك الآن تسجيل الدخول.']);
    }

    public function login(Request $request)
    {
        $request->validate(['phone' => 'required', 'password' => 'required']);

        $user = $this->auth->login($request->phone, $request->password);

        if ($user === 'locked') {
        return response()->json([
            'message' => 'تم قفل حسابك مؤقتًا. الرجاء الانتظار قبل المحاولة مرة أخرى.'
        ], 423);
    }

    if ($user === 'wrong_password') {
        return response()->json([
            'message' => 'بيانات الدخول غير صحيحة.'
        ], 401);
    }

        if ($user === 'not_verified') {
            return response()->json(['message' => 'يرجى التحقق من حسابك أولاً.'], 403);
        }

        if (! $user) {
            throw ValidationException::withMessages(['phone' => ['بيانات الدخول غير صحيحة.']]);
        }

        $token = $user->createToken('api_token')->plainTextToken;
        return response()->json(['user' => $user, 'token' => $token]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'تم تسجيل الخروج.']);
    }

  public function employeeSendOtp(Request $request)
{
    $data = $request->validate([
        'phone'  => 'required|exists:users,phone',
        'method' => 'required|in:email,whatsapp',
        'value'  => 'required|string'
    ]);

    $user = \App\Models\User::where('phone', $data['phone'])->first();
    $userid = \App\Models\User::where('phone', $data['phone'])->get('id');

    if (!$user || $user->role !== 'employee') {
        return response()->json(['message' => 'الحساب غير صالح أو ليس موظفاً.'], 403);
    }

    $result = $this->auth->sendOtpForEmployee(
        $user,
        $data['method'],
        $data['value'],
        
    );

    return response()->json([$result,$userid]);
}


}
