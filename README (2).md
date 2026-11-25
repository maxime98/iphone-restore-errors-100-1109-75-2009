# PowerShell diagnostics (Windows 10/11)

Run in Windows PowerShell 5.1. These commands observe state; they do not change the backup or interrupt a restore. The supplied script samples aggregate process I/O; it cannot prove exact bytes received by the phone.

## USB enumeration

```powershell
Get-PnpDevice -PresentOnly | Where-Object {$_.FriendlyName -match 'Apple|iPhone' -or $_.InstanceId -match 'VID_05AC'} | Format-List Status,Class,FriendlyName,InstanceId
```

## Active driver versions

```powershell
Get-CimInstance Win32_PnPSignedDriver | Where-Object {$_.DeviceName -match 'Apple|iPhone'} | Format-Table DeviceName,DriverVersion,InfName,DriverProviderName -AutoSize
```

## Apple processes and local TCP

```powershell
Get-Process | Where-Object {$_.ProcessName -match 'Apple|iMazing|Backup|Restore|usbmux'} | Format-Table ProcessName,Id,CPU,WorkingSet -AutoSize
```

```powershell
Get-NetTCPConnection -LocalPort 27015 -ErrorAction SilentlyContinue | Format-Table LocalAddress,LocalPort,RemoteAddress,RemotePort,State,OwningProcess -AutoSize
```

```powershell
Test-NetConnection 127.0.0.1 -Port 27015
```

## Measure activity

```powershell
.\Measure-RestoreIO.ps1 -Seconds 30
```

Or use the original one-line approach:

```powershell
$a=Get-CimInstance Win32_Process | Where-Object {$_.Name -match 'Apple|iMazing|Backup|Restore|usbmux'}; Start-Sleep -Seconds 30; Get-CimInstance Win32_Process | Where-Object {$_.Name -match 'Apple|iMazing|Backup|Restore|usbmux'} | ForEach-Object {$p=$_;$o=$a | Where-Object {$_.ProcessId -eq $p.ProcessId}; if($o){[PSCustomObject]@{Process=$p.Name;PID=$p.ProcessId;ReadMiB=[math]::Round(($p.ReadTransferCount-$o.ReadTransferCount)/1MB,3);WriteMiB=[math]::Round(($p.WriteTransferCount-$o.WriteTransferCount)/1MB,3);OtherMiB=[math]::Round(($p.OtherTransferCount-$o.OtherTransferCount)/1MB,3)}}} | Format-Table -AutoSize
```

## Find logs

```powershell
Get-ChildItem "$env:APPDATA\Apple Computer\Logs","$env:LOCALAPPDATA\Packages\AppleInc.AppleDevices_nzyj5cx40ttqa\LocalCache\Roaming\Apple Computer\Logs","$env:APPDATA\iMazing\Caches\Logs" -Recurse -File -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 15 FullName,LastWriteTime,Length | Format-List
```

```powershell
Get-Content -LiteralPath 'PATH-TO-LOG' -Tail 30 -Wait
```

Ctrl+C stops only the tail command. Redact personal paths, device IDs, tokens and account information before posting output.

## Optional USB troubleshooting — NOT during restoration

Administrator privileges required. Use only if no backup/restore is active. First inspect the exact currently connected instance and driver INF, then substitute those values. Exporting a driver is precautionary; it does not back up user data.

```powershell
New-Item -ItemType Directory -Path 'C:\AppleDriverBackup' -Force; pnputil /export-driver oemNNN.inf 'C:\AppleDriverBackup'
```

```powershell
pnputil /restart-device 'EXACT-CURRENT-USB-INSTANCE-ID'
```

If Windows requires a reboot, save work, ensure copies and restores are finished, then reboot normally. Do not delete drivers or registry filters. A downgrade was considered but not performed in this incident.
