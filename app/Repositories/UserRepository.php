<?php

namespace App\Repositories;

use App\Models\User;

class UserRepository
{
    public function findByPhone(string $phone): ?User
    {
        return User::where('phone', $phone)->first();
    }

    public function findById(int $id): ?User
    {
        return User::find($id);
    }

    public function create(array $data): User
    {
        return User::create($data);
    }

    public function findEmployeeById($id): ?User
    {
        return User::where('role', 'employee')->find($id);
    }

    public function delete(User $user): bool
    {
        return $user->delete();
    }

    public function countAll(): int
    {
        return User::count();
    }

    public function countByRole(string $role): int
    {
        return User::where('role', $role)->count();
    }

    public function getAllForExport(): array
    {
        return User::select('id','name','email','phone','role','created_at')
        ->orderByDesc('id')
        ->get()
        ->toArray();
    }

    public function incrementFailedAttempts(User $user)
{
    $user->failed_attempts++;
    $user->save();
}

public function resetFailedAttempts(User $user)
{
    $user->failed_attempts = 0;
    $user->save();
}

public function lockUser(User $user, int $minutes)
{
    $user->locked_until = now()->addMinutes($minutes);
    $user->save();
}
public function getEmployees()
{
    return \App\Models\User::where('role', 'employee')
        ->select('id','name','email','phone','department_id','created_at')
        ->with('department:id,name')
        ->get();
}
public function update(User $user, array $data): User
{
    $user->update($data);
    return $user;
}
}
