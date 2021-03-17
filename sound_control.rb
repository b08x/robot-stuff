#!/usr/bin/env ruby

require 'shellwords'
require 'childprocess'

args = ARGV[0]

def status(service)
  status = `pgrep -l #{service}`.chomp.split.last
  return status
end

case args
when "start"
  begin
    system("pulseaudio -k") if status("pulseaudio")
    system("jack_control start") unless status("jackdbus")
    system("a2j_control start") unless status("a2jmidid")
    system("pulseaudio --start")
  rescue => e
    puts e
  end
when "stop"
  begin
    system("jack_control exit")
    system("a2j_control exit")
  rescue => e
    puts e
  end
end
