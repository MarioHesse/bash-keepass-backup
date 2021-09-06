#!/usr/bin/env zsh

# User Einstellungen
FOLDER=/home/mario/Dropbox/keepass          # Ordner, in dem die Datei liegt
FILE=mh-pw.kdbx                             # Datei, die zum Backup vorgesehen ist
BACKUP_SUBFOLDER=Backup                     # Unterordner, in dem das Backup abgelegt werden soll
DATE="$(date +"%Y-%m-%d") $(date +"%T")"    # Erstellen des Zeitstempels für den Backup Dateinamen


# Erstellen aller vollständigen Pfade
BACKUP_FOLDER="$FOLDER/$BACKUP_SUBFOLDER"                       # Pfad zum Backupordner
FROM="$FOLDER/$FILE"                                            # Pfad zur Originaldatei
TO="$BACKUP_FOLDER/$DATE $BACKUP_SUBFOLDER Autostart - $FILE"   # Pfad zur Backupdatei


# Prüfen, ob der Backupunterordner bereits angelegt ist und falls nicht, ggf. erstellen
if ! [[ -d "$BACKUP_FOLDER" ]]
then
  mkdir "$BACKUP_FOLDER/"
fi

# Backup anlegen (Kopieren der Datei → Statusausgabe wird in Variable geschrieben)
COPY_OUTPUT=$(cp -v "$FROM" "$TO")

# Ausgabe des Kopierstatus mit Datum in einem Log-File
echo "$DATE: $COPY_OUTPUT" >> "$BACKUP_FOLDER/$BACKUP_SUBFOLDER.log"
