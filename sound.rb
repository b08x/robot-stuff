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
    system('/usr/bin/st -ai -f "Hack Nerd Font Mono" -e "/usr/bin/alsamixer"')
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

case args
when 'openmixer'
  openmixer
when 'start'
  start
when 'setlevel'
  puts "hey"
  setlevel('PCM', '80%')
  setlevel('Master', '80%')
  setlevel('Headphone', '80%')
  setlevel('Speaker', '0%')
  mute('Speaker')
  %w[Master Headphone].each { |x| unmute(x) }
end

# amixer: Unknown command 'name=Capture Switch'...
toggleswitch("Capture Switch")

#{-----------------------------------------------------------------------------}
# echo 3072 > /sys/class/rtc/rtc0/max_user_freq
#
# cpupower -c all frequency-set -g performance
