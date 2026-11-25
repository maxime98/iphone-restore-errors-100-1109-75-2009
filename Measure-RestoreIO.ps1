[CmdletBinding()]
param([ValidateRange(1,600)][int]$Seconds=30)
$pattern = 'Apple|iMazing|Backup|Restore|usbmux'
$before = Get-CimInstance Win32_Process | Where-Object {$_.Name -match $pattern}
Start-Sleep -Seconds $Seconds
$after = Get-CimInstance Win32_Process | Where-Object {$_.Name -match $pattern}
foreach ($p in $after) {
    $old = $before | Where-Object {$_.ProcessId -eq $p.ProcessId -and $_.CreationDate -eq $p.CreationDate} | Select-Object -First 1
    if ($old) {
        [pscustomobject]@{
            Process = $p.Name
            PID = $p.ProcessId
            ReadMiB = [math]::Round(($p.ReadTransferCount-$old.ReadTransferCount)/1MB,3)
            WriteMiB = [math]::Round(($p.WriteTransferCount-$old.WriteTransferCount)/1MB,3)
            OtherMiB = [math]::Round(($p.OtherTransferCount-$old.OtherTransferCount)/1MB,3)
            State = 'Sampled'
        }
    } else {
        [pscustomobject]@{Process=$p.Name;PID=$p.ProcessId;ReadMiB=$null;WriteMiB=$null;OtherMiB=$null;State='New process'}
    }
}
foreach ($old in $before) {
    if (-not ($after | Where-Object {$_.ProcessId -eq $old.ProcessId -and $_.CreationDate -eq $old.CreationDate})) {
        [pscustomobject]@{Process=$old.Name;PID=$old.ProcessId;ReadMiB=$null;WriteMiB=$null;OtherMiB=$null;State='Exited'}
    }
}
