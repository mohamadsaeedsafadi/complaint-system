<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;

class Complaint extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'reference_no','user_id','department_id','assigned_to','title','description','location','status'
    ];

    public function user() {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function department() {
        return $this->belongsTo(Department::class);
    }

    public function assignedEmployee() {
        return $this->belongsTo(User::class, 'assigned_to');
    }

    public function attachments() {
        return $this->hasMany(ComplaintAttachment::class);
    }

    public function history() {
        return $this->hasMany(ComplaintStatusHistory::class);
    }
    public function messages()
{
    return $this->hasMany(\App\Models\ComplaintMessage::class);
}

}

