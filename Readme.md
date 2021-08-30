# Bash script: keepass-backup

This bash script is used to create a daily backup of my KeePass2 database in a subfolder. I use it with anacron (additional tool to cron). But you can also use it for other backups of single files.


| variables        | function                                                                |
| ---------------- | ----------------------------------------------------------------------- |
| FILE             | file from which a backup should be created                              |
| FOLDER           | path to the folder of FILE                                              |
| BACKUP_SUBFOLDER | Name of the folder for the backup (if not existing, it will be created) |
| DATE             | Date format for the prefix of the backup file                           |
