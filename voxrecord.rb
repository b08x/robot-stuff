#!/usr/bin/env ruby

require 'tty-command'
require 'osc-ruby'

CAPTURES = File.join(ENV['HOME'], "Studio", "jack_capture")

# toggle capture on, mute speakers

# start carla-rack

# connect capture input to carla
jack_connect system:capture_1 Carla:audio-in1
jack_connect system:capture_2 Carla:audio-in2

# start jack_capture

# send osc message to start record

# send osc message to stop record

timemachine system:capture_1 system:capture_2 -t 10 -f wav -o 8888 -a -b -20 -e -25 -T 5

jack_capture_cmd = "jack_capture -f wav -mb -tm -tmpb 10 --channels 2 --port Carla:audio-out* --osc 9999 --daemon"

noise_filter_cmd = "carla-rack -n vox_record.carxp"

@carla = OSC::Client.new('127.0.0.1', 22752)
@jack_capture = OSC::Client.new('127.0.0.1', 9999)

$amixer = 'systemd-cat /usr/bin/amixer -D'

def toggleswitch(switch)
  `#{$amixer} #{DEVICE} cset name='#{switch}' toggle`
end

filter environment noise
mute speakers

jack_capture


oscsend localhost 9999 /jack_capture/tm/start

unsilence

# to set the hpf
client.send(OSC::Message.new("/Carla/0/set_parameter_value", 0, 20.0 ))
