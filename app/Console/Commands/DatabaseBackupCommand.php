<?php

namespace App\Console\Commands;

use App\Services\BackupService;
use Illuminate\Console\Command;
class DatabaseBackupCommand extends Command
{
    protected $signature = 'backup:database';
    protected $description = 'Create database backup';

    public function __construct(protected BackupService $backupService)
    {
        parent::__construct();
    }

  public function handle()
{
    $backup = $this->backupService->createBackup();

    if ($backup->status === 'success') {
        $this->info('Backup created successfully: ' . $backup->file_name);
    } else {
        $this->error('Backup failed: ' . $backup->error);
    }
}

}

