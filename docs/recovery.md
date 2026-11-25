# Recovery runbook

## 0. Protect the data first

Keep an untouched master backup and make an independent working copy. Verify the copy completed and compare file counts, total bytes and preferably hashes. Do not create a new backup into the old backup location, repair the only copy, or share backup files online.

Common Windows paths:

- Apple Devices / Store iTunes: `%USERPROFILE%\Apple\MobileSync\Backup\<UDID>`
- Classic iTunes: `%APPDATA%\Apple Computer\MobileSync\Backup\<UDID>`

Expected layout: `Info.plist`, `Manifest.plist`, `Manifest.db`, `Status.plist`, and hashed payload directories. A `finished` snapshot and `IsFullBackup=false` mean an incremental snapshot was recorded as finished, not that all files have been verified. In this case the 10:38 backup was the intended one; a 12:54 folder was not used.

## 1. Establish a bootable phone

Only if the OS is not functional: follow official Apple recovery instructions. Error 75 in this incident explicitly required erase; this is destructive and must not be repeated merely to troubleshoot personal-data restoration. Standalone iTunes 12.13.11.1 restored firmware successfully. Once the OS works, do not reflash unnecessarily.

## 2. Diagnose standard restore failure

Use Restore Backup, not Restore iPhone. If standard restore has already erased the phone, check DeviceLink logs and whether payload transfer starts. Repeated EOF/broken pipe plus no sustained progress can justify stopping a stalled attempt only after confirming no active transfer. A second PC can isolate machine-specific factors. In this case Windows 10 reproduced the failure.

## 3. Prepare iMazing

The successful transfer was made on the primary Windows 11 PC with iTunes and Apple Devices removed and iMazing using its own MobileDevice components. This exact software isolation is an observed setup, not a universal prerequisite.

- Finish initial phone setup without transferring data; reach the home screen. Unlock and trust the computer. Preserve any current data before proceeding.
- If needed use iMazing's Reinstall Mobile Device Services option. Check Windows device enumeration and local TCP diagnostics. A USB device restart or PC reboot may help if recognition fails; do not do either during active restoration. Stop iMazing Mini if it is running automatic backup tasks, after confirming it is idle.
- Browse the working backup in iMazing. Confirm date, device, size and actual readable photos/messages.
- Disable Find My temporarily only as requested by the restore wizard, with the owner's authorization. Re-enable after completion.
- Select Backups → Restore to Devices → correct target phone. A paid license was required; this is not a sponsorship or guarantee.

## 4. Critical restore settings

| Setting | Observed selection |
|---|---|
| Data | All datasets |
| Apps | All apps |
| Install apps from local library | Unchecked |
| **Erase target devices** | **Unchecked** |
| Allow MDM enrollment | Unchecked |

Even with erase unchecked, the restore replaces target data. App installation may depend on App Store availability, Apple Account authentication and app-specific rules. Unencrypted backups omit some sensitive categories.

## 5. Monitor and finalize

Initially the wizard showed Preparing restore, and the phone Restore in Progress, with very little I/O. Do not assume this is a failure. The UI later displayed real byte and percentage progress. At 92% a reported five-minute pause resolved on its own. Keep power, USB and Windows awake, and do not terminate processes. After transfer, let the phone reboot and follow its on-device instructions (swipe up to update, Apple logo/progress bar in this case). Do not force-restart during this phase.

## 6. Acceptance checklist (not yet completed in the incident record)

- [x] Backup recognized and sample messages visible
- [x] Photo catalogue lists 14,582 items
- [x] Data transfer completed and reboot observed
- [ ] iMazing confirms successful finalization
- [ ] Home screen accessible
- [ ] Original photos open at full resolution; verify recent and old samples
- [ ] SMS/iMessage, WhatsApp and Messenger checked separately
- [ ] Contacts, notes, key apps and account access verified
- [ ] Find My re-enabled
- [ ] Fresh backup made to a separate location; master retained

Official support entry points (not claims of independent verification of this incident):
- Apple backup restore: https://support.apple.com/118105
- iMazing support: https://imazing.com/support
- Microsoft PnPUtil: https://learn.microsoft.com/windows-hardware/drivers/devtest/pnputil-command-syntax
