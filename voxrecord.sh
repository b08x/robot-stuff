#!/usr/bin/env bash

filter environment noise

time-machine 

unsilence

if pulseaudio is running and timemachine is run
jackd is started which then takes control over 
the audio card, which will pause/stop any
pulseaudio playback. once timemachine is closed
pulseaudio takes back control over the card. if any
audio was playing via pulse, it will resume. 
