<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ActivityLog extends Model
{
    protected $fillable = [
        'user_id',
        'action',
        'route',
        'method',
        'ip',
        'request_payload',
        'response_status',
        'duration_ms',
    ];

    protected $casts = [
        'request_payload' => 'array',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
