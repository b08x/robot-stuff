#!/usr/bin/env bash

MOUNT_STATUS=$(mount | grep bender)

# sync
if [ -d $MOUNT_STATUS ]
  then
    echo "bender not mounted"
    exit
fi

rsync -avnz --partial --inplace --append --progress --recursive --stats \
--exclude-from=/home/b08x/.filter /home/b08x/ /mnt/bender/b08x/


# click button in waybar
# run rsync -n to show what files would be sent to bender
# display diff
# prompt; backup now?

# run rsync -n in the opposite direction
# display diff
# prompt; sync from bender?


# workspace = home/workspace
# workspace.children do {|folder in git repo| check status, prompt commit, push }
