#!/bin/bash
BACKUPFILE="Test1"
BACKUPLOCATION="./BackupTest1/"
KEEPFILESYOUNGERTHAN="+30"
LOGFILE="BackupLog"
#Check if the file exists
if [ -e "$BACKUPFILE" ]; then
	#Check if the folder exists
	if [ -d "$BACKUPLOCATION" ]; then
		#Date the files, day at end for easier parsing by eye.
		DATE=$(date +"%Y-%m-%d")
		#Copy the file to the backup location
		cp -r $BACKUPFILE $BACKUPLOCATION$BACKUPFILE-$DATE
		#Find all files older than the keep time window, and then remove them
		find $BACKUPLOCATION -mtime $KEEPFILESYOUNGERTHAN -exec rm {} \;
	else 	#Backup Folder location doesn't exist
		echo "[$(date +"%Y-%m-%d")]: Unable to find destination to copy to. Directory doesn't exist." >> $LOGFILE
	fi
else #File to be backed up doesn't exist at the location
	echo "[$(date +"%Y-%m-%d %H:%M")]: Unable to file file to back up. File doesn't exist." >> $LOGFILE
fi
