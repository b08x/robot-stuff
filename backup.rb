#!/usr/bin/env bash

SRC="/"
SNAPSHOTS="/media/b08x/snapshots"

RSYNC="rsync -aii --recursive --verbose --delete --force --stats --delete-excluded"

TIMESTAMP = Time.now.strftime("%Y-%m-%d_%H%M")

EXCLUDE=File.join(SNAPSHOTS, "exclude.list")


def rsync(link)
end

--link-dest="#{SNAPSHOTS}/#{_PREVIOUS_TIMESTAMP}/"
--log-file=File.join(SNAPSHOTS, PREVIOUS_TIMESTAMP, 'rsync.log')
--exclude-from=/media/root/timeshift/timeshift/snapshots/2021-04-04_04-06-18/exclude.list
--delete-excluded #{SRC} /media/root/timeshift/timeshift/snapshots/2021-04-04_04-06-18/localhost/
