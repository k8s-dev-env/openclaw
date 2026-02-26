#!/bin/bash

read -e -p "Enter the backup file name: " backup_file

if [ -f "$backup_file" ]; then
  unzip -o "$backup_file"
  tar -xvf openclaw-data-$DATE.tar.gz
  rm -rf openclaw-data-$DATE.tar.gz
  echo "Backup restored from $backup_file"
else
  echo "Backup file not found: $backup_file"
fi