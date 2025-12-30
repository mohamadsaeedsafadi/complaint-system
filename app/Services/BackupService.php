<?php

namespace App\Services;

use App\Models\DatabaseBackup;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class BackupService
{
    public function createBackup(): DatabaseBackup
    {
        $filename = 'backup_' . now()->format('Y_m_d_His') . '.sql';
        $path = 'backups/' . $filename;

        try {
            $sql = $this->generateSqlBackup();

            Storage::disk('local')->put($path, $sql);

            return DatabaseBackup::create([
                'file_name' => $filename,
                'path' => $path,
                'status' => 'success',
            ]);

        } catch (\Throwable $e) {
            return DatabaseBackup::create([
                'file_name' => $filename,
                'path' => $path,
                'status' => 'failed',
                'error' => $e->getMessage(),
            ]);
        }
    }

    protected function generateSqlBackup(): string
    {
        $output = "-- Database Backup\n";
        $output .= "-- Date: " . now() . "\n\n";
        $output .= "SET FOREIGN_KEY_CHECKS=0;\n\n";

        $tables = DB::select('SHOW TABLES');
        $dbName = env('DB_DATABASE');

        foreach ($tables as $table) {
            $tableName = $table->{"Tables_in_$dbName"};

            // Create table
            $create = DB::select("SHOW CREATE TABLE `$tableName`")[0]->{'Create Table'};
            $output .= "\nDROP TABLE IF EXISTS `$tableName`;\n";
            $output .= $create . ";\n\n";

            // Insert data
            $rows = DB::table($tableName)->get();
            foreach ($rows as $row) {
                $values = array_map(function ($value) {
                    return is_null($value)
                        ? 'NULL'
                        : "'" . addslashes($value) . "'";
                }, (array) $row);

                $output .= "INSERT INTO `$tableName` VALUES (" . implode(',', $values) . ");\n";
            }

            $output .= "\n";
        }

        $output .= "SET FOREIGN_KEY_CHECKS=1;\n";

        return $output;
    }
}
