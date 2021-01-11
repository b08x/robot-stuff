#!/usr/bin/env bash

MOUNT_STATUS=$(mount | grep bender)

SRC="/home/b08x/"
DEST="/mnt/bender/b08x/"

RSYNC="rsync -aiiP --recursive --verbose --force --stats --sparse"

if [[ -d $MOUNT_STATUS ]]
  then
    echo "bender not mounted"
    exit
fi

$RSYNC --exclude-from="$HOME/.filter" "$SRC" "$DEST" > "$HOME/backup.log" &

# run rsync -n in the opposite direction
