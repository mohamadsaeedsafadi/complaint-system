<?php

namespace App\Services;

use App\Models\User;
use App\Repositories\OtpRepository;
use Illuminate\Support\Facades\Mail;

class OtpSenderService
{
    public function __construct(
        protected OtpRepository $otps
    ) {}

    public function sendOtp(User $user, string $method): array
    {
        $code = rand(100000, 999999);

        $this->otps->createForUser($user->id, $code, $method);

        if ($method === 'email') {
            Mail::raw("رمز التحقق الخاص بك هو: {$code}", function ($msg) use ($user) {
                $msg->to($user->email)->subject('رمز التحقق');
            });
        }

        if ($method === 'whatsapp') {
              $clean = preg_replace('/[^0-9]/', '', $user->phone);
            $whatsapp = "https://wa.me/$clean?text=" . urlencode("رمز التحقق الخاص بك هو: $code");
        }

        return [
            'message' => 'تم إرسال رمز التحقق',
            'sent_to' => $method
        ];
    }
}