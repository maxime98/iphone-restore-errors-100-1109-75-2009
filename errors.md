# iPhone restore errors 100, 1109, 75, 2009, 0xe800005d and Broken pipe

## Separate the two failure modes

**Firmware recovery** reinstalls the OS. **Backup restoration** transfers personal data into an operational OS. The former succeeded at 12:40:43; the latter was the recurring problem afterward.

| Error / observation | Evidence and interpretation | Confidence / response |
|---|---|---|
| Error 100 / 1109 | Reported during initial Apple Devices attempts. No specific cause established. | Reported only; do not assign a generic code meaning. |
| Error 75 / Missing data volume on APFS formatted device, erase required | Explicit firmware restore log; update without erase could not proceed. | Direct evidence for this attempt; preserve backup before any erase. |
| Error 2009 / unable to query iBoot ramdisk-size / boot logo push failed | Two iTunes recovery attempts failed before successful firmware restore. | Direct evidence; underlying USB or recovery cause unproven. |
| `SocketRecv (data): return of 0 bytes` | DeviceLink stream closed. | Direct evidence; may be a normal consequence of erase/disconnect, not itself the root cause. |
| `NULL data returned from read` / `Broken pipe` | Subsequent read/write failure on closed stream. | Reproduced on both Windows PCs. |
| `kAMDInvalidHostIDError` | Session could not start with existing host identity after erase. | Consistent with lost pairing; no proof of why recovery did not resume. |
| `kAMDPasswordProtectedError` (0xe800001a) | Initial pairing attempt on secondary PC failed before successful pairing. | Direct evidence; unlock/trust resolved initial pairing. |
| `kAMDServiceProhibitedError` (0xe800005d) | Requested services unavailable during post-erase setup. | Direct evidence; device state may explain this, not proof of corruption. |
| `AMDIsTXTRecordForUDID: Failed to derive key` | Repeated MobileDevice messages. | No proof of backup encryption/key corruption. Backup metadata says unencrypted. |
| `SHLWAPI.dll` warning | Appeared in both successful/failed communication contexts. | Causal role not established; do not download replacement DLLs. |
| `NSInvalidArgumentException` / `containsString:` / `AMBArchiveBackupRequest` | AppleMobileDeviceHelper exception during archive request. | Direct evidence of helper failure; not proven to cause restore failure. |
| iMazing cannot connect to Apple devices | Generic startup diagnostic; TCP 27015 listening; USBMux ListDevices empty during troubleshooting. | USB detection recovered after restart/reconnection. Firewall disablement not needed. |
| iMazing installer iPod service XML error | Installer nevertheless reported driver and component installation success. | Relevance to iPhone not established. |
| `pnputil` Access denied / device not connected / reboot required | Observed during USB troubleshooting. | Elevation, current device presence, and Windows reboot respectively addressed operational prerequisites. |

## Individual error reference

### iPhone restore error 100 and error 1109 — Apple Devices
Reported early in the incident. Their specific causes were not established.

### iPhone update error 75 — Missing data volume on APFS formatted device, erase required
The firmware log explicitly reported a missing APFS data volume. Preserve the backup before considering an erase. Firmware restoration and personal-data restoration are separate operations.

### iPhone restore error 2009 — libusbrestore error:2009
Two recovery attempts failed, with `Unable to query iBoot ramdisk-size. Libusbrestore error : 268435456` and `_AMRestorePushBootLogo failed with 2009` in the logs. A later firmware restore succeeded; the precise cause of 2009 was not established.

### AppleMobileBackup.exe error 32: Broken pipe — SocketRecv return of 0 bytes
The stream closed around the erase operation on both PCs. `NULL data returned from read` followed. This was not proof of backup corruption.

### kAMDInvalidHostIDError — iPhone pairing after erase
The host session failed after reconnecting. The pairing and activation sequence is a suspected failure point, not a proven root cause.

### 0xe800005d — kAMDServiceProhibitedError
Repeated service-start refusals occurred during post-erase setup, including application lookup and power assertion requests.

### 0xe800001a — kAMDPasswordProtectedError
Initial pairing failed while password protection was active; subsequent pairing succeeded after the unlock/trust sequence.

### NSInvalidArgumentException — containsString: unrecognized selector — AMBArchiveBackupRequest
An AppleMobileDeviceHelper.exe exception was observed. Its relationship to the subsequent restoration failure is unknown.

### AMDIsTXTRecordForUDID — Failed to derive key; SHLWAPI.dll warning
Neither diagnostic established backup encryption, corruption or the root cause. Do not download replacement DLLs from third-party sites.

### iMazing cannot connect to your Apple devices — USBMux DeviceList empty
TCP 27015 responded to a ListDevices request, but the device list was empty during troubleshooting. Windows USB enumeration alone was insufficient. Restarting the device/reconnecting and later rebooting Windows preceded recovery of detection.

### iPhone stuck on Restore in Progress — iMazing restore without preliminary erase
Apple Devices stalled on both Windows 10 and 11. iMazing with **Erase target devices unchecked** subsequently completed the reported transfer of the 63.18 GB backup. Final on-device data verification remains pending in the record. See [recovery procedure](recovery.md).

## Hypotheses ranked by evidence, not probability scores

- Strongest observed pattern: Apple Devices loses the data restoration session around erase and fails to resume after reconnecting. Reproduced on two Windows machines. Avoiding preliminary erase coincided with a complete transfer in iMazing.
- A specific bug in Apple Devices, its common MobileDevice stack, or an interaction with iOS setup state remains possible. A shared cable/device factor was not completely excluded.
- A Windows 11-only issue, a single damaged PC installation or a simple local TCP firewall block is less consistent with the evidence.
- Backup corruption is not established. Successful browsing and completed transfer support usability, but do not prove every file or app database is intact.
- Low storage before the upgrade was reported, but its causal role is unknown.

## Diagnostic pitfalls

TCP connectivity proves only local transport. Windows PnP status `OK` proves enumeration, not end-to-end restore. A phone screen saying Restore in Progress is not proof of transfer. Process I/O is aggregate, not exact USB payload. A single idle interval is not enough to declare failure. Use UI progress, logs and repeated observations together.
