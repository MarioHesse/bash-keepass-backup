#!/usr/bin/env zsh

# User Settings
LOCATION=/home/mario/Nextcloud/Gespensterfisch/keepass  # location of the backup file
BACKUP_FILE=mh-pw.kdbx                                  # name of the backup file
BACKUP_FOLDER=Backup                                    # subfolder to store the backup in
BACKUP_DATE="$(date +"%F_W%W_%H%M%S")"                  # time stamp for the backup


# create path to backup location
BACKUP_LOCATION="$LOCATION/$BACKUP_FOLDER"

# backup type ist per default "none" - no backup will be stored
TYPE="none"

# Daily
#   In case there is no file with the actual year, month and day
#   with the type "daily" a new daily-backup will be stored
if [[ "$(ls -1 ${BACKUP_LOCATION}/$(date +"%Y-%m-%d")*daily*$BACKUP_FILE | wc -l)" == "0" ]]
then
  TYPE="daily"
fi

# Weekly
#   In case there is no file with the actual year and week
#   with the type "weekly" a new weekly-backup will be stored
if [[ "$(ls -1 ${BACKUP_LOCATION}/$(date +"%Y")*$(date +"W%W")*weekly*$BACKUP_FILE | wc -l)" == "0" ]]
then
  TYPE="weekly"
fi

# Monthly
#   In case there is no file with the actual year and month
#   with the type "monthly" a new mothly-backup will be stored
if [[ "$(ls -1 ${BACKUP_LOCATION}/$(date +"%Y-%m")*monthly*$BACKUP_FILE | wc -l)" == "0" ]]
then
  TYPE="monthly"
fi

# Yearly
#   In case there is no file with the actual year
#   with the type "yearly" a new yearly-backup will be stored
if [[ "$(ls -1 ${BACKUP_LOCATION}/$(date +"%Y")*yearly*$BACKUP_FILE | wc -l)" == "0" ]]
then
  TYPE="yearly"
fi


# Create Backup, if it is not "none"
#   else do nothing
if ! [[ "$TYPE" == "none" ]]
then

  FROM="$LOCATION/$BACKUP_FILE"                                       # path to original file
  TO="$BACKUP_LOCATION/${BACKUP_DATE}_${TYPE}-backup_$BACKUP_FILE"    # path to backup file


  # check existens of backup folder, in case its not existing create it
  if ! [[ -d "$BACKUP_LOCATION" ]]
  then
    mkdir "$BACKUP_LOCATION/"
  fi

  # create backup (copy file) → status will be printed out
  COPY_OUTPUT=$(cp -v "$FROM" "$TO")

  # print copy status to log file
  echo "$BACKUP_DATE: $COPY_OUTPUT" >> "$BACKUP_LOCATION/$BACKUP_FOLDER.log"

else
  echo "Backup alredy exists - nothing to do here! :-)"
fi
