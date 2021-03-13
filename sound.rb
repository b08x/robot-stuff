#!/usr/bin/env ruby


DEVICE = 'hw:0'.freeze

$amixer = 'systemd-cat /usr/bin/amixer -D'

args = ARGV[0]

def mute(thing)
  `#{$amixer} #{DEVICE} set #{thing} mute`
end

def unmute(thing)
  `#{$amixer} #{DEVICE} set #{thing} unmute`
end

def setlevel(name, lvl)
  `#{$amixer} #{DEVICE} set #{name} #{lvl}`
end

def ssetlevel(name, lvl, mute)
  `#{$amixer} #{DEVICE} sset #{name},0 #{lvl} #{mute}`
end

def toggleswitch(switch)
  `#{$amixer} #{DEVICE} cset name='#{switch}' toggle`
end

def incvol(name)
  `#{$amixer} #{DEVICE} -M set #{name} 3dB+`
end

def decvol(name)
  `#{$amixer} #{DEVICE} -M set #{name} 3dB-`
end

def openmixer
  fork do
    system('/usr/bin/terminator -e "/usr/bin/alsamixer"')
    exit
  end
end


def start
  `systemctl --user stop pulseaudio.service`
  `notify-send "stopping pulse"`
  `jack_control start`
  `notify-send "starting jack"`
  sleep 1
  `a2j_control --start`
  `notify-send "starting a2j_control"`
  `systemctl --user start pulseaudio.service`
  `notify-send "starting pulse"`
end

def stop
  `jack_control exit`
  `a2j_control --exit`
  `systemctl --user stop pulseaudio.service`
end

case args
when "mixer"
  openmixer
when "start"
  start

  ssetlevel("Master", "58", "unmute")
  ssetlevel("Headphone", "0", "mute")
  ssetlevel("Front", "58", "unmute")
  ssetlevel("Surround", "58", "unmute")
  ssetlevel("Center", "0", "mute")
  ssetlevel("LFE", "0", "mute")
  ssetlevel("Capture", "0", "mute")
  setlevel("PCM", "90%")

  # amixer: Unknown command 'name=Capture Switch'...
  toggleswitch("Capture Switch")
when stop
  stop
end



#{-----------------------------------------------------------------------------}
# echo 3072 > /sys/class/rtc/rtc0/max_user_freq
#
# cpupower -c all frequency-set -g performance
