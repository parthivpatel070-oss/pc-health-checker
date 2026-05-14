Write-Host "=== PC Health Check ===" -ForegroundColor Cyan

# CPU Usage
$cpu = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty LoadPercentage
Write-Host "CPU Usage: $cpu%"

if ($cpu -gt 80) {
    Write-Host "WARNING: High CPU Usage!" -ForegroundColor Red
}

# RAM Information
$ram = Get-CimInstance Win32_OperatingSystem

$totalRAM = [math]::Round($ram.TotalVisibleMemorySize / 1MB, 2)
$freeRAM = [math]::Round($ram.FreePhysicalMemory / 1MB, 2)

Write-Host "Total RAM: $totalRAM GB"
Write-Host "Free RAM: $freeRAM GB"

if ($freeRAM -lt 2) {
    Write-Host "WARNING: Low Available RAM!" -ForegroundColor Red
}

# Disk Space
Write-Host "`nDisk Space:"
$disk = Get-PSDrive C

$used = [math]::Round($disk.Used / 1GB, 2)
$free = [math]::Round($disk.Free / 1GB, 2)

Write-Host "Used Space: $used GB"
Write-Host "Free Space: $free GB"

if ($free -lt 10) {
    Write-Host "WARNING: Low Disk Space!" -ForegroundColor Red
}

# System Uptime
$uptime = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime

Write-Host "`nSystem Uptime: $uptime"

Write-Host "`nHealth Check Complete." -ForegroundColor Green