# Incident chronology

All times on 2026-11-24, Eastern Standard Time. `~` indicates an approximate time or a conversation-derived observation; exact timestamps come from logs or recorded screenshots. Firmware logs have local headers and UTC internal timestamps, converted here to EST.

| Local time | Attempt / event | Outcome |
|---|---|---|
| Morning | Apple Devices upgrade; phone reportedly had less than 20 GB free | Error 100; later restore errors 1109 reported. Exact times not established. |
| 10:38 | Original local backup timestamp in Info.plist (15:38 UTC) | Snapshot marked finished; unencrypted, incremental. |
| 12:23–12:24:51 | Standalone iTunes firmware update | Error 75: missing APFS data volume; erase required. |
| 12:27–12:27:53 | Recovery restore | Error 2009, unable to query iBoot ramdisk size. |
| 12:28–12:28:32 | Another recovery attempt | Error 2009, boot logo push failed. |
| 12:31:40–12:40:43 | iTunes firmware restore | Restore successful; OS booted. |
| 12:54:12 | iTunes helper archive request | NSInvalidArgumentException / containsString: unrecognized selector. A second backup directory appeared; not used as original. |
| 13:14:03–13:14:07 | Apple Devices pairing | InvalidHostIDError followed by successful pairing. |
| 13:25:38 | Apple Devices data restoration | Socket EOF / Broken pipe reported; no payload transfer established. |
| ~15:20–15:23:35 | Reset target pairing record, reboot, re-pair | Initial failure then successful pairing; other device records preserved. |
| 15:26:34 | Retry Apple Devices | Same socket failure reported. |
| ~15:36 | Try restore from initial iOS setup (From Mac or PC) | Restore in Progress on phone; process I/O essentially idle. |
| ~15:54–16:11 | Install iMazing and its bundled Apple components; remove standalone iTunes/Apple Devices | Drivers installed per installer log; initial detection still failed. |
| ~16:12–16:25 | TCP 27015 and USBMux ListDevices tests | TCP and XML response valid, DeviceList empty while troubleshooting; Windows enumerated Apple USB interfaces. |
| 16:25 | Export active Apple driver; restart USB device and reconnect | iMazing subsequently recognized phone. Exact causal step uncertain. |
| 16:27–16:35 | Browse original backup | 63.18 GB, 14,582 photos listed, messages visible; restore wizard allows erase unchecked. |
| ~16:36–17:00 | License prompt; defer purchase; test iMazing Mini | Mini not useful for this attempt. Prepare secondary PC. |
| 17:07:42 | Windows 10 Apple Devices pairing | Successful. |
| 17:08:03–17:08:05 | Start backup restoration on Windows 10 | Socket EOF / Broken pipe. Phone erased. |
| 17:08:54 | Reconnection | InvalidHostIDError. |
| 17:09:15–17:09:32 | Apple services requested | Repeated ServiceProhibitedError. |
| 17:10:26 | New AppleMobileBackup process (PID 3568) | 30-second I/O sample zero across monitored processes; phone shows Restore in Progress. |
| ~17:11–17:29 | Return to Windows 11, activate iMazing, configure phone, restart PC when requested by PnP utility | USB interfaces OK; close automatically started iMazing Mini, launch main iMazing. |
| 17:30–17:31 | Link phone to license, start restore with erase unchecked | Preparing restore; phone Restore in Progress; initially very low I/O. |
| 17:33:21 | First visible transfer | 1%, 374.33 MB, 2,880 files; UI speed 30.86 MB/s. |
| ~17:34 onward | Process I/O sample | iMazing read 209.371 MiB and AppleMobileDeviceProcess other I/O 211.989 MiB over 30 seconds. Progress reached 6%. |
| 17:56:04 | Progress screenshot | 54%, 34.48 GB, 35,720 files; displayed speed 30.52 MB/s. |
| ~18:07–18:12 | User reports pause of about five minutes | Progress resumed. |
| 18:12:30 | Progress screenshot | 92%, 58.80 GB, 57,089 files; displayed speed 30.60 MB/s. |
| 18:16:39 | Transfer completed; iMazing reboot phase | About 43 minutes from first visible transfer. |
| After 18:16 | Phone rebooted; swipe up to update; Apple logo and progress bar | Final OS/data migration observed. Home screen and individual data validation not yet recorded. |

The timestamps on screenshots are derived from their UTC filenames and converted to EST. The measured duration is a case observation, not an estimate for other devices. The morning error order and timing are based on the incident narrative, not a complete timestamped log.
