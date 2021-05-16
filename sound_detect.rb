#!/usr/bin/ruby -w
#
# Copyright (C) 2009 Thomer M. Gil [http://thomer.com/]
#
# Oct  22, 2009: Initial version
#
# This program is free software. You may distribute it under the terms of
# the GNU General Public License as published by the Free Software
# Foundation, version 2.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
# Public License for more details.
#
# This program detects the presence of sound and invokes a program.
#

require 'getoptlong'

# You need to replace MICROPHONE with the name of your microphone, as reported
# by /proc/asound/cards
MICROPHONE = 'PowerMicIINS'
HWDEVICE = `cat /proc/asound/cards | grep '#{MICROPHONE}' | awk '{print $1}'`.to_i
SAMPLE_DURATION = 5 # seconds
FORMAT = 'S16_LE'   # this is the format that my USB microphone generates
THRESHOLD = 0.15

if !File.exist?('/usr/bin/arecord')
  warn "/usr/bin/arecord not found; install package alsa-utils"
  exit 1
end

if !File.exist?('/usr/bin/sox')
  warn "/usr/bin/sox not found; install package sox"
  exit 1
end

if !File.exist?('/proc/asound/cards')
  warn "/proc/asound/cards not found"
  exit 1
end

$options = {}
opts = GetoptLong.new(*[
  [ "--verbose", "-v", GetoptLong::NO_ARGUMENT ],
])
opts.each { |opt, arg| $options[opt] = arg }

loop do
  out = `/usr/bin/arecord -D plughw:#{HWDEVICE},0 -d #{SAMPLE_DURATION} -f #{FORMAT} 2>/dev/null | /usr/bin/sox -t .wav - -n stat 2>&1`
  out.match(/Maximum amplitude:\s+(.*)/m)
  amplitude = $1.to_f
  puts amplitude if $options['--verbose']
  if amplitude > THRESHOLD
    # You need to replace this with the program you wish to run
    puts "sound!"
  else
    puts "no sound"
  end
end
