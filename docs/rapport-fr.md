# Restauration iPhone 14 bloquée — erreurs 100, 1109, 75, 2009 sous Windows

**24 novembre 2026 — heure de l'Est (UTC−5).** L'objectif était de récupérer une sauvegarde locale de 63,18 Go réalisée à 10 h 38 avant la perte des données. La sauvegarde iOS 26.5 était non chiffrée et le téléphone a finalement démarré avec une version affichée comme iOS 27.2.1.

## Déroulement

Le matin, Apple Devices a rencontré les erreurs 100 et 1109 (rapportées). À 12 h 24, iTunes a signalé l'erreur 75 et l'absence du volume de données APFS. Deux tentatives suivantes ont échoué avec l'erreur 2009. À 12 h 40 min 43 s, iTunes 12.13.11.1 a réussi la restauration du système.

La restauration des données personnelles est restée bloquée : rupture de connexion (Broken pipe), identité d'hôte invalide après effacement, puis refus de démarrer certains services iOS. Un deuxième ordinateur sous Windows 10 a reproduit le même scénario à 17 h 08. La reconnaissance de l'iPhone par Windows était pourtant correcte.

Sur le PC Windows 11, iMazing 3.6.5 a été installé avec ses propres composants Apple. Après des problèmes initiaux de détection, le redémarrage du périphérique USB puis, plus tard, du PC a précédé le retour à une connexion opérationnelle. Le pilote 552.0.0.0 a été exporté par précaution, mais aucun retour au pilote 538 n'est documenté.

La sauvegarde a été reconnue : 14 582 photos détectées et anciens messages consultables. Une licence payante a été activée. Le master était conservé séparément selon l'utilisateur.

## Messages d’erreur à rechercher

- `Missing data volume on APFS formatted device, erase required` (75)
- `Failed to restore device in recovery mode, libusbrestore error:2009`
- `SocketRecv (data): return of 0 bytes` ; `NULL data returned from read` ; `SocketSend (data): error 32: Broken pipe`
- `kAMDInvalidHostIDError` ; `0xe800005d (kAMDServiceProhibitedError)` ; `0xe800001a (kAMDPasswordProtectedError)`
- `NSInvalidArgumentException` ; `containsString:` ; `AMBArchiveBackupRequest`
- `AMDIsTXTRecordForUDID` ; `Failed to derive key` ; `SHLWAPI.dll`
- iPhone bloqué sur « Restore in Progress » ; iMazing ne détecte pas l’iPhone (USBMux DeviceList vide)

## Solution de contournement observée

Dans iMazing, restaurer toutes les données et applications en laissant **Erase target devices décoché**, depuis un iPhone déjà configuré, associé et déverrouillé. Cette option évite l'effacement préalable, mais remplace les données présentes sur la destination.

| Heure | Avancement |
|---|---|
| 17 h 31 | Préparation, très faible activité initiale |
| 17 h 33 | 1 %, transfert réel |
| 17 h 56 | 54 %, 34,48 Go |
| 18 h 12 | 92 %, 58,80 Go |
| 18 h 16 | Transfert terminé, redémarrage |
| Ensuite | Balayer vers le haut pour mettre à jour, logo Apple et barre de progression |

## Conclusion

Le transfert intégral annoncé par iMazing a été atteint, contrairement aux tentatives Apple Devices. L'hypothèse principale est un blocage du cycle effacement/reconnexion, sans cause racine démontrée. La validation finale (écran d'accueil, photos originales, messages, WhatsApp, applications) n'est pas encore documentée. Ne pas présenter ce cas comme une réparation universelle ni comme une récupération de toutes les données déjà vérifiée.

La [chronologie détaillée](timeline.md), les [erreurs](errors.md), la [procédure](recovery.md) et les [commandes](../scripts/README.md) sont disponibles en anglais pour faciliter la publication internationale.
