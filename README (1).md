# Evidence index

The included excerpt file contains selected lines from the incident record. Source names below are for traceability; original private logs and backups are intentionally excluded.

| Source | Supports |
|---|---|
| Info.plist, Manifest.plist, Status.plist | Backup date, device type, OS, encryption and snapshot state |
| iPhoneUpdater 8.log | Error 75, missing APFS data volume |
| iPhoneUpdater 9.log and 10.log | Error 2009 |
| iPhoneUpdater 11.log | Successful firmware recovery |
| asl.123134_241126.log | Helper archive exception |
| asl.131353_241126.log and its later copy | Pairing failure/recovery |
| Windows 10 pasted DeviceLink log and ASL log | EOF, broken pipe, host identity and service errors, new backup process |
| User-pasted PowerShell output | Driver inventory, PnP status, TCP, USBMux and I/O |
| iMazing screenshots and incident conversation | Backup size, restore options, transfer checkpoints and reboot |

Older updater logs from 2024, 2025 and earlier 2026 incidents were excluded from this case. In particular a standalone AppleMobileBackup.exe.00.log in the supplied collection dates to 2024 and is not evidence for the November 2026 failure. Screenshots are not published to avoid disclosure of personal data.

See [selected excerpts](selected-excerpts.txt). Bracketed source labels and redactions are editorial. Firmware internal timestamps are UTC; ASL and DeviceLink timestamps are local.
