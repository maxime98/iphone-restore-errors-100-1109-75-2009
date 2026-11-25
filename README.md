# iPhone Restore Errors 100, 1109, 75, 2009 — Apple Devices Broken Pipe on Windows 10/11

**Incident:** 24 November 2026 · **Device:** iPhone 14 (`iPhone14,7`) · **Status:** data transfer completed; final on-device validation pending in the available record.

A local, unencrypted 63.18 GB iPhone backup could not be restored using Apple Devices on two separate Windows computers. The application erased the phone but repeatedly lost the restoration session. iMazing 3.6.5 subsequently transferred the backup with **Erase target devices disabled**. The phone rebooted and entered its final on-device update phase.

> This is a single incident report, not an official Apple or DigiDNA fix. The root cause has not been proven. Do not erase a phone or modify its only backup to reproduce this case.

## Error codes and searchable diagnostic messages

If Apple Devices erases your iPhone but gets stuck on **Restore in Progress**, or fails to restore a local backup, this case study covers the following observed symptoms. The workaround completed the data transfer; it is not a universal fix for every listed error.

| Error code or exact message | Context |
|---|---|
| iPhone restore error 100 | Initial Apple Devices failure, reported |
| iPhone restore error 1109 | Initial Apple Devices failure, reported |
| `Code:75 Error:Missing data volume on APFS formatted device, erase required` | Firmware update failure |
| `Code:2009 Error:Failed to restore device in recovery mode, libusbrestore error:2009` | Firmware recovery failure |
| `Unable to query iBoot ramdisk-size. Libusbrestore error : 268435456` | Recovery attempt |
| `SocketRecv (data): return of 0 bytes` | AppleMobileBackup.exe / DeviceLink |
| `NULL data returned from read` | DeviceLink read failure |
| `SocketSend (data): error 32: Broken pipe` | DeviceLink write failure |
| `kAMDInvalidHostIDError` | Session failure after erase |
| `0xe800005d (kAMDServiceProhibitedError)` | Post-erase service access refused |
| `0xe800001a (kAMDPasswordProtectedError)` | Initial pairing failure |
| `AMDIsTXTRecordForUDID: Failed to derive key` | MobileDevice diagnostic |
| `Could not load library SHLWAPI.dll` | AMPDevicesAgent.exe warning |
| `NSInvalidArgumentException` / `containsString:` / `unrecognized selector` / `AMBArchiveBackupRequest` | AppleMobileDeviceHelper.exe exception |
| `iMazing cannot connect to your Apple devices` | Initial iMazing connection failure |
| `DeviceList` empty | USBMux response on TCP port 27015 |
| `Restore in Progress` stuck | No meaningful transfer observed with Apple Devices |

See [individual error explanations and troubleshooting](docs/errors.md) and [sanitized log excerpts](evidence/selected-excerpts.txt).

## TL;DR

1. Preserve a separate master copy of the entire backup directory.
2. If firmware installation failed and logs explicitly report a missing APFS data volume, distinguish firmware recovery from personal-data restoration. In this case iTunes restored the OS successfully; repeating firmware restores did not solve the data restore issue.
3. If Apple Devices repeatedly erases the phone and stalls, check USB enumeration, pairing, process I/O and DeviceLink logs. Try a second computer if available.
4. Once the phone is operational and configured, use iMazing to browse a **working copy** of the original backup. Verify actual photos and messages.
5. Restore all data and apps with **Erase target devices unchecked**. This still replaces target data. A paid license was required in this case.
6. Keep the USB connection and power stable until the app and phone finish. Verify actual user data before declaring success.

## Repository map

| File | Purpose |
|---|---|
| [Chronology](docs/timeline.md) | Time-stamped incident history |
| [Error analysis](docs/errors.md) | Error messages, interpretations and limitations |
| [Recovery runbook](docs/recovery.md) | Practical recovery sequence and verification |
| [Rapport français](docs/rapport-fr.md) | French summary of the incident |
| [PowerShell diagnostics](scripts/README.md) | Read-only Windows monitoring commands |
| [Evidence](evidence/README.md) | Selected sanitized excerpts and provenance |

## Environment

- Windows 11 primary PC; Windows 10 secondary PC.
- Original backup iOS 26.5, build 23F77; target OS displayed as iOS 27.2.1 in the incident UI (reported, not independently verified).
- Standalone iTunes 12.13.11.1; Apple Devices package versions 1.1792.39682.0 (primary) and 1.1792.39681.0 (secondary); MobileDevice.framework 1860.49.2 on secondary.
- Apple USB driver 552.0.0.0 (April 25, 2025); iMazing 3.6.5.0.
- Backup: 63.18 GB displayed by iMazing, 14,582 photos listed, messages browsable; full integrity not established.

## Privacy and scope

No raw backup, pairing record, personal screenshots, device identifiers or full diagnostic logs are distributed. Times are local US Eastern time (EST, UTC−05:00) unless indicated. Dates and software versions are reported as observed, not a compatibility claim. No affiliation with Apple or DigiDNA.
