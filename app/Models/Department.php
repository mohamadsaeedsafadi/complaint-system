<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Department extends Model
{
    use HasFactory;
    protected $fillable = ['name','code','description'];

    public function employees() {
        return $this->hasMany(User::class)->where('role','employee');
    }

    public function complaints() {
        return $this->hasMany(Complaint::class);
    }
}

