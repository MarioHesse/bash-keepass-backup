#!/bin/bash

# Start des Backups anzeigen
date
echo "  --- Start Backup ---"


# User Einstellungen
FOLDER=/home/mario/Dropbox/keepass              # Ordner, in dem die Datei liegt
FILE=mh-pw.kdbx                                 # Datei, die zum Backup vorgesehen ist
BACKUP_SUBFOLDER=Backup                         # Unterordner, in den das Backup abgelegt werden soll
DATE="$(date +"%Y-%m-%d") $(date +"%T")"        # Erstellen des Zeitstempels für den Backup Dateinamen


# Erstellen aller vollständigen Pfade
BACKUP_FOLDER="$FOLDER/$BACKUP_SUBFOLDER"           # Pfad zum Backupordner
FROM="$FOLDER/$FILE"                                # Pfad zur Originaldatei
TO="$BACKUP_FOLDER/$DATE $BACKUP_SUBFOLDER $FILE"   # Pfad zur Backupdatei


# Prüfen, ob der Backupunterordner bereits angelegt ist und ggf. erstellen
if [[ -d "$BACKUP_FOLDER" ]]
then
    echo "  Backup folder '$BACKUP_FOLDER' - OK!"
else
    mkdir "$BACKUP_FOLDER/"
	echo "  Backup folder '$BACKUP_FOLDER' created!"
fi


# Backup anlegen
COPY_OUTPUT=$(cp -v "$FROM" "$TO")      # Kopieren der Datei → Status Ausgabe wird in Variable geschrieben
echo "  $COPY_OUTPUT"                   # Ausgabe des Kopier-Status mit Einrückung


# Ende des Backups anzeigen
echo "  --- End Backup ---"
