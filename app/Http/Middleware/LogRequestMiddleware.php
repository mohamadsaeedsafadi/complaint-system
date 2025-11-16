<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Log;
use App\Repositories\ActivityLogRepository;
use Illuminate\Support\Arr;

class LogRequestMiddleware
{
    protected ActivityLogRepository $activityRepo;

    public function __construct(ActivityLogRepository $activityRepo)
    {
        $this->activityRepo = $activityRepo;
    }

    public function handle($request, Closure $next)
    {
        $start = microtime(true);

        
        $userId = optional($request->user())->id;
        $route = $request->path();
        $method = $request->method();
        $ip = $request->ip();

        
        $payload = $request->except(['password', 'password_confirmation', 'current_password', 'file', 'attachments', 'attachment']);
        

        $response = $next($request);

        $duration = (int) round((microtime(true) - $start) * 1000);

        $status = $response->getStatusCode();

    
        Log::info('API Request', [
            'user_id' => $userId,
            'route' => $route,
            'method' => $method,
            'ip' => $ip,
            'status' => $status,
            'duration_ms' => $duration,
        ]);

        
        try {
            $this->activityRepo->create([
                'user_id' => $userId,
                'action' => $this->guessAction($request),
                'route' => $route,
                'method' => $method,
                'ip' => $ip,
                'request_payload' => $this->sanitizePayload($payload),
                'response_status' => $status,
                'duration_ms' => $duration,
            ]);
        } catch (\Throwable $e) {
            
            Log::error('Failed to create activity log: '.$e->getMessage());
        }

        return $response;
    }

    
    protected function guessAction($request): string
    {
        
        $method = $request->method();
        $path = $request->path();

        if (stripos($path, 'login') !== false) return 'login';
        if (stripos($path, 'register') !== false) return 'register';
        if (stripos($path, 'send-otp') !== false || stripos($path, 'otp') !== false) return 'send_otp';
        if ($method === 'POST') return 'create';
        if ($method === 'PATCH' || $method === 'PUT') return 'update';
        if ($method === 'DELETE') return 'delete';
        return strtolower($method).'_'.str_replace('/', '_', $path);
    }

    protected function sanitizePayload(array $payload): array
    {
    
        $clean = Arr::except($payload, ['large_text', 'long_description']);
        
        array_walk_recursive($clean, function (&$v, $k) {
            if (is_string($v) && strlen($v) > 1000) {
                $v = substr($v, 0, 1000) . '...';
            }
        });
        return $clean;
    }
}
