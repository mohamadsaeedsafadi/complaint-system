<?php

namespace App\Services;

use App\Repositories\UserRepository;
use App\Repositories\OtpRepository;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use App\Models\User;

class AuthService
{
    public function __construct(
        protected UserRepository $users,
        protected OtpRepository $otps,
       protected OtpSenderService $otpSender
    ) {}

    public function register(array $data): User
    {
        $data['password'] = Hash::make($data['password']);
        return $this->users->create($data);
    }

    public function sendOtp(User $user, string $method): array
    {
        $this->otps->deleteByUser($user->id);
        $code = rand(100000, 999999);

        $otp = $this->otps->create([
            'user_id' => $user->id,
            'method' => $method,
            'contact' => $method === 'email' ? $user->email : $user->phone,
            'code' => $code,
            'expires_at' => now()->addMinutes(5),
        ]);

        if ($method === 'email' && $user->email) {
            Mail::raw("رمز التحقق الخاص بك هو: $code", function ($message) use ($user) {
                $message->to($user->email)->subject('رمز التحقق من نظام الشكاوى');
            });
        }

        $whatsapp = null;
        if ($method === 'whatsapp') {
            $clean = preg_replace('/[^0-9]/', '', $user->phone);
            $whatsapp = "https://wa.me/$clean?text=" . urlencode("رمز التحقق الخاص بك هو: $code");
        }

        return [
            'message' => $method === 'email'
                ? 'تم إرسال رمز التحقق إلى بريدك الإلكتروني.'
                : 'تم إنشاء رابط واتساب لإرسال رمز التحقق.',
            'link' => $whatsapp,
            'debug_code' => $code,
        ];
    }

    public function verifyOtp(int $userId, string $code): bool
    {
        $otp = $this->otps->getByUser($userId);
        if (! $otp) return false;
        if (now()->greaterThan($otp->expires_at)) return false;
        if ($otp->code !== $code) return false;

        $user = $this->users->findById($userId);
        if ($otp->method === 'email') {
            $user->email_verified_at = now();
        } else {
            $user->phone_verified_at = now();
        }
        $user->save();

        $this->otps->deleteByUser($userId);
        return true;
    }

    public function login(string $phone, string $password)
{
    $user = $this->users->findByPhone($phone);
    if (! $user) return null;

    if ($user->locked_until && now()->lessThan($user->locked_until)) {
        return 'locked';
    }

    if (! Hash::check($password, $user->password)) {

        $user->failed_attempts++;

        if ($user->failed_attempts >= 5) {

            $user->locked_until = now()->addMinutes(10);
            $user->save();

            if ($user->email) {
                Mail::raw(
                    "تم قفل حسابك لمدة 10 دقائق بسبب محاولات غير صحيحة.",
                    fn($msg) => $msg->to($user->email)->subject("تنبيه أمني | قفل الحساب")
                );
            }

            return 'locked';
        }

        $user->save();
        return 'wrong_password';
    }

    $user->failed_attempts = 0;
    $user->locked_until = null;
    $user->save();

    if (is_null($user->phone_verified_at) && is_null($user->email_verified_at)) {
        return 'not_verified';
    }

    return $user;
}


    public function sendOtpByUserId(int $userId, string $method)
{
    $user = $this->users->findById($userId);
    return $this->sendOtp($user, $method);
}

public function chooseVerificationMethod(User $user, string $method, string $value)
    {
        if ($method === 'email') {
            $this->users->update($user, ['email' => $value]);
        } else {
            $this->users->update($user, ['phone' => $value]);
        }

        return true;
    }

public function sendOtpForEmployee(User $user, string $method, string $value): array
{
    $this->otps->deleteByUser($user->id);

    if ($method === 'email') {
        $user->email = $value;
    } else {
        $user->phone = preg_replace('/[^0-9]/', '', $value);
    }
    $user->save();

    $code = rand(100000, 999999);

    $this->otps->create([
        'user_id'    => $user->id,
        'method'     => $method,
        'contact'    => $value,
        'code'       => $code,
        'expires_at' => now()->addMinutes(5),
    ]);

    if ($method === 'email') {
        Mail::raw("رمز التحقق الخاص بك هو: $code", function ($msg) use ($value) {
            $msg->to($value)->subject("رمز التحقق للموظف");
        });

        return [
            'message' => 'تم إرسال الرمز إلى البريد الإلكتروني.',
            'debug_code' => $code
        ];
    }

    $cleanPhone = preg_replace('/[^0-9]/', '', $value);
    $url = "https://wa.me/$cleanPhone?text=" . urlencode("رمز التحقق الخاص بك هو: $code");

    return [
        'message' => 'تم إنشاء رابط واتساب لإرسال الرمز.',
        'link'    => $url,
        'debug_code' => $code
    ];
}

public function sendOtpToExistingUser(int $userId, string $method): array
{
    $user = $this->users->findById($userId);

    if (! $user) {
        throw new \Exception("User not found");
    }

    if ($method === 'email' && empty($user->email)) {
        throw new \Exception("User does not have an email");
    }

    return $this->otpSender->sendOtp($user, $method);
}


}
