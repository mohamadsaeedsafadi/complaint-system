<?php

namespace App\Repositories;

use App\Models\OtpCode;
use Carbon\Carbon;

class OtpRepository
{
    public function create(array $data): OtpCode
    {
        return OtpCode::create($data);
    }

    public function deleteByUser(int $userId)
    {
        return OtpCode::where('user_id', $userId)->delete();
    }

    public function getByUser(int $userId): ?OtpCode
    {
        return OtpCode::where('user_id', $userId)->first();
    }
    public function createForUser(int $userId, string $code, string $method): OtpCode
    {
        OtpCode::where('user_id', $userId)->delete();

        return OtpCode::create([
            'user_id' => $userId,
            'code' => $code,
            'method' => $method,
            'expires_at' => Carbon::now()->addMinutes(5)
        ]);
    }

    public function verify(int $userId, string $code): bool
    {
        $otp = OtpCode::where('user_id', $userId)
            ->where('code', $code)
            ->where('expires_at', '>=', now())
            ->first();

        if (! $otp) {
            return false;
        }

        $otp->delete();

        return true;
    }

}

