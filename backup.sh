#!/bin/sh

# Define backup directory
backupdir=~/stack/backups

# Create mysql backup directory
mkdir $backupdir/mysql

# Create sites backup directory
mkdir $backupdir/sites

# Backup all databases to backup directory
echo 'Export all databases'
for database in $(mysql -e "show databases"|awk -F " " '{print $1}'); do
    mysqldump $database | gzip -9 > $backupdir/mysql/$database.sql.gz
done

# Backup all sites
echo 'Resync all Sites folders'
rsync -arv --exclude=node_modules --exclude=bower_components /Users/jasperrooduijn/sites/ $backupdir/sites/