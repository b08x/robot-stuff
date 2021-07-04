#!/usr/bin/env ruby

ssh -X soundbot01

jack_control start


# set levels
amixer

timemachine system:capture_1 system:capture_2 system:capture_3 system:capture_4 -t 10 -f wav -o 8888 -a -b -5.0 -e -25 -T 5

# check disk space
every 14 minutes check
use unix app


# move files to bender

script launches timemachine
exits
cron job to check disk space
calls this script with the arg "move"
