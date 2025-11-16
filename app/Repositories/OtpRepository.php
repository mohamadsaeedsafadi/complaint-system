<?php

namespace App\Repositories;

use App\Models\OtpCode;

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
}
