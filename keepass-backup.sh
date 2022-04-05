#!/usr/bin/env zsh

# User Einstellungen
FOLDER=/home/mario/Dropbox/keepass      # Ordner, in dem die Datei liegt
FILE=mh-pw.kdbx                         # Datei, die zum Backup vorgesehen ist
BACKUP_SUBFOLDER=Backup                 # Unterordner, in dem das Backup abgelegt werden soll
DATE="$(date +"%F")_$(date +"%H%M%S")"  # Format des Zeitstempels für den Backup-Dateinamen


# Standardmäßig -> Backuptyp "Täglich" (daily-backup)
TYPE="daily"

# Falls Montag ist -> Backuptyp "Wöchentlich" (weekly-backup)
if [[ $(date +"%u") == "1" ]]
then
  TYPE="weekly"
fi

# Falls 1. des Monats ist -> Backuptyp "Monatlich" (monthly-backup)
if [[ $(date +"%d") == "01" ]]
then
  TYPE="monthly"
fi


# Erstellen aller vollständigen Pfade
BACKUP_FOLDER="$FOLDER/$BACKUP_SUBFOLDER"      # Pfad zum Backupordner
FROM="$FOLDER/$FILE"                           # Pfad zur Originaldatei
TO="$BACKUP_FOLDER/${DATE}_${TYPE}-backup_$FILE"   # Pfad zur Backupdatei


# Prüfen, ob der Backupunterordner bereits angelegt ist und falls nicht, ggf. erstellen
if ! [[ -d "$BACKUP_FOLDER" ]]
then
  mkdir "$BACKUP_FOLDER/"
fi

# Backup anlegen (Kopieren der Datei → Statusausgabe wird in Variable geschrieben)
COPY_OUTPUT=$(cp -v "$FROM" "$TO")

# Ausgabe des Kopierstatus mit Datum in einem Log-File
echo "$DATE: $COPY_OUTPUT" >> "$BACKUP_FOLDER/$BACKUP_SUBFOLDER.log"
