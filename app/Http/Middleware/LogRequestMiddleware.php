<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Log;
use App\Repositories\ActivityLogRepository;
use Illuminate\Support\Arr;
use Throwable;

class LogRequestMiddleware
{
    public function __construct(
        protected ActivityLogRepository $activityRepo
    ) {}

    public function handle($request, Closure $next)
    {
        /** ===============================
         * BEFORE (Before Advice)
         * =============================== */
        $startTime = microtime(true);

        $context = [
            'user_id' => optional($request->user())->id,
            'route' => $request->path(),
            'method' => $request->method(),
            'ip' => $request->ip(),
            'request_payload' => $this->sanitizePayload(
                $request->except([
                    'password',
                    'password_confirmation',
                    'current_password',
                    'file',
                    'files',
                    'attachments',
                    'attachment',
                ])
            ),
        ];

        try {
            /** ===============================
             * PROCEED (Around Advice)
             * =============================== */
            $response = $next($request);

            /** ===============================
             * AFTER RETURNING (Success)
             * =============================== */
            $this->logSuccess($context, $response, $startTime);

            return $response;

        } catch (Throwable $e) {

            /** ===============================
             * AFTER THROWING (Exception)
             * =============================== */
            $this->logException($context, $e, $startTime);

            throw $e;
        }
    }

    /** ===============================
     * AFTER RETURNING
     * =============================== */
    protected function logSuccess(array $context, $response, float $startTime): void
    {
        $duration = (int) ((microtime(true) - $startTime) * 1000);

        $this->activityRepo->create([
            'user_id' => $context['user_id'],
            'action' => $this->guessAction(
                $context['method'],
                $context['route']
            ),
            'route' => $context['route'],
            'method' => $context['method'],
            'ip' => $context['ip'],
            'request_payload' => $context['request_payload'],
            'response_status' => $response->getStatusCode(),
            'duration_ms' => $duration,
        ]);
    }

    /** ===============================
     * AFTER THROWING
     * =============================== */
    protected function logException(array $context, Throwable $e, float $startTime): void
    {
        $duration = (int) ((microtime(true) - $startTime) * 1000);

        Log::error('API Exception', [
            'exception' => $e->getMessage(),
            'route' => $context['route'],
            'method' => $context['method'],
        ]);

        $this->activityRepo->create([
            'user_id' => $context['user_id'],
            'action' => 'exception',
            'route' => $context['route'],
            'method' => $context['method'],
            'ip' => $context['ip'],
            'request_payload' => $context['request_payload'],
            'response_status' => 500,
            'duration_ms' => $duration,
        ]);
    }

    protected function guessAction(string $method, string $path): string
    {
        if (str_contains($path, 'login')) return 'login';
        if (str_contains($path, 'register')) return 'register';
        if (str_contains($path, 'otp')) return 'otp';

        return match ($method) {
            'POST' => 'create',
            'PUT', 'PATCH' => 'update',
            'DELETE' => 'delete',
            default => 'read',
        };
    }

    protected function sanitizePayload(array $payload): array
    {
        $clean = Arr::except($payload, ['large_text', 'long_description']);

        array_walk_recursive($clean, function (&$value) {
            if (is_string($value) && strlen($value) > 1000) {
                $value = substr($value, 0, 1000) . '...';
            }
        });

        return $clean;
    }
}
