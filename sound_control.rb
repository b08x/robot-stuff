#!/usr/bin/env ruby

require 'shellwords'
require 'childprocess'

DEVICE = 'hw:0'.freeze

$amixer = '/usr/bin/amixer -D'

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

def status(service)
  status = `pgrep -l #{service}`.chomp.split.last
  return status
end

def openmixer
  fork do
    system('/usr/bin/terminator -e "/usr/bin/alsamixer"')
    exit
  end
end

case args
when "start"
  begin
    system("notify-send 'starting jack'")
    system("pulseaudio -k") if status("pulseaudio")
    system("jack_control start") unless status("jackdbus")
    sleep 0.5
    system("a2j_control --start") unless status("a2jmidid")
    system("pulseaudio --start")
  rescue => e
    puts e
  end
when "stop"
  begin
    system("notify-send 'stopping jack'")
    system("jack_control exit")
    system("a2j_control --exit")
  rescue => e
    puts e
  end
when "levels"
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
  openmixer
end
