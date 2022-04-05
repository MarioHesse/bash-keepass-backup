#!/usr/bin/env zsh

# User Einstellungen
FOLDER=/home/mario/Dropbox/keepass      # Ordner, in dem die Datei liegt
FILE=mh-pw.kdbx                         # Datei, die zum Backup vorgesehen ist
BACKUP_SUBFOLDER=Backup                 # Unterordner, in dem das Backup abgelegt werden soll
DATE="$(date +"%F_W%W_%H%M%S")"         # Format des Zeitstempels für den Backup-Dateinamen


# Erstellen aller vollständigen Pfade
BACKUP_FOLDER="$FOLDER/$BACKUP_SUBFOLDER"           # Pfad zum Backupordner
FROM="$FOLDER/$FILE"                                # Pfad zur Originaldatei

# Daily
#   Standardmäßig wird ein tägliches Backup erstellt (daily-backup)
TYPE="daily"

# Weekly
#   Falls noch keine Datei mit dem aktuellen Jahr, der aktuellen Woche und dem Tag
#   "weekly" existiert, wird ein weekly-backup angelegt
if ! [[ "$(ls -1 ${BACKUP_FOLDER}/$(date +"%Y")*$(date +"W%W")*weekly*$FILE | wc -l)" > "0" ]]
then
  TYPE="weekly"
fi

# Monthly
#   Falls noch keine Datei mit dem aktuellen Jahr, dem aktuellen Monat und dem Tag
#   "monthly" existiert, wird ein monthly-backup angelegt
if ! [[ "$(ls -1 ${BACKUP_FOLDER}/$(date +"%Y-%m")*monthly*$FILE | wc -l)" > "0" ]]
then
  TYPE="monthly"
fi

# Yearly
#   Falls noch keine Datei mit dem aktuellen Jahr und dem Tag "yearly" existiert,
#   wird ein yearly-backup angelegt
if ! [[ "$(ls -1 ${BACKUP_FOLDER}/$(date +"%Y")*yearly*$FILE | wc -l)" > "0" ]]
then
  TYPE="yearly"
fi

TO="$BACKUP_FOLDER/${DATE}_${TYPE}-backup_$FILE"    # Pfad zur Backupdatei


# Prüfen, ob der Backupunterordner bereits angelegt ist und falls nicht, ggf. erstellen
if ! [[ -d "$BACKUP_FOLDER" ]]
then
  mkdir "$BACKUP_FOLDER/"
fi

# Backup anlegen (Kopieren der Datei → Statusausgabe wird in Variable geschrieben)
COPY_OUTPUT=$(cp -v "$FROM" "$TO")

# Ausgabe des Kopierstatus mit Datum in einem Log-File
echo "$DATE: $COPY_OUTPUT" >> "$BACKUP_FOLDER/$BACKUP_SUBFOLDER.log"
