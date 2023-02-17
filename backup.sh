#!/bin/bash
###################################################################
#
# Backup directorys and MySQL DB to Google Drive and Yandex Disk.
# Using Rclone, ZIP, MySQLDump
#
###################################################################

now=`date +%d-%m-%Y-%H.%M.%S`

# Print status message
echo '[' `date +%d-%m-%Y.%H:%M:%S` '] Zipping files'
zip -qr $now-files.zip /www 

# Print status message
echo '[' `date +%d-%m-%Y.%H:%M:%S` '] Upload file to Google Drive'

# Upload to GD
rclone -P copy $now-files.zip google:/backup/LinuxHome
#echo '[' `date +%d-%m-%Y.%H:%M:%S` '] Upload file to Yandex Disk'
#rclone -P copy $now-files.zip yandex:/backup/LinuxHome
echo '[' `date +%d-%m-%Y.%H:%M:%S` '] Delete file'
rm $now-files.zip


echo '[' `date +%d-%m-%Y.%H:%M:%S` '] SQL dump'
mysqldump --all-databases > all-databases.sql
echo '[' `date +%d-%m-%Y.%H:%M:%S` '] Zipping SQL dump files'
zip -qr $now-mysql.zip all-databases.sql
rm all-databases.sql
echo '[' `date +%d-%m-%Y.%H:%M:%S` '] Upload SQL dump file to Google Drive'
rclone -P copy $now-mysql.zip google:/backup/LinuxHome
#echo '[' `date +%d-%m-%Y.%H:%M:%S` '] Upload SQL dump file to Yandex Disk'
#rclone -P copy $now-mysql.zip yandex:/backup/LinuxHome
echo '[' `date +%d-%m-%Y.%H:%M:%S` '] Delete SQL dump file'
rm $now-mysql.zip