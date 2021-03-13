#!/usr/bin/env bash

SRC="/home/b08x/"
DEST="/mnt/bender/b08x/"

RSYNC="rsync -aiinP --recursive --verbose --force --stats --sparse"

mountpoint -q $DEST

if [[ $? == 0 ]]
then
  $RSYNC --exclude-from="$HOME/.filter" "$SRC" "$DEST" > "$HOME/backup.log" &
  wait
else
  echo "bender not mounted" > "$HOME/backup.log"
fi

# run rsync -n in the opposite direction
