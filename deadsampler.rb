#!/usr/bin/env ruby

require 'tempfile'
require 'tty-command'

files = ARGV

cmd = TTY::Command.new(printer: :pretty)

files.each do |file|
  cmd.run("terminator -b")
end
# files.each do |x|
# `terminator -e echo "#{x}"`
# sleep 1
# end
