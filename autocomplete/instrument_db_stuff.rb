#!/usr/bin/env ruby

require 'pty'
require 'expect'
require 'tty-command'
require 'fileutils'
require 'open3'


# cmd = TTY::Command.new

# test = "LIST DB_INSTRUMENTS RECURSIVE '/'"
#
# stdout, status = Open3.capture2('netcat 127.0.0.1 8888 -q 1', stdin_data: test )
#
# puts stdout
#
# lscp=#

PTY.spawn("lscp") do |r,w,pid|
  w.sync = true
  $expect_verbose = true
  r.expect(/lscp=# /)
  w.printf("LIST DB_INSTRUMENTS RECURSIVE '/'\n")
  pid.wait
end

# lscp=# ADD DB_INSTRUMENTS RECURSIVE FILE_AS_DIR '/brass' '/home/b08x/Library/Sounds/soundfonts/brass'
# OK
# lscp=# ADD DB_INSTRUMENTS RECURSIVE FILE_AS_DIR '/collections' '/home/b08x/Studio/library/sounds/collections'
# OK
# lscp=# ADD DB_INSTRUMENTS RECURSIVE FILE_AS_DIR '/keys' '/home/b08x/Studio/library/sounds/keys'
# OK
# lscp=# ADD DB_INSTRUMENTS RECURSIVE FILE_AS_DIR '/loops' '/home/b08x/Studio/library/sounds/loops'
# OK
# lscp=# ADD DB_INSTRUMENTS RECURSIVE FILE_AS_DIR '/percussions' '/home/b08x/Studio/library/sounds/percussions'
# OK
# lscp=# ADD DB_INSTRUMENTS RECURSIVE FILE_AS_DIR '/sfx' '/home/b08x/Studio/library/sounds/sfx'
# OK
# lscp=# ADD DB_INSTRUMENTS RECURSIVE FILE_AS_DIR '/strings' '/home/b08x/Studio/library/sounds/strings'
# OK
# lscp=# ADD DB_INSTRUMENTS RECURSIVE FILE_AS_DIR '/synths' '/home/b08x/Studio/library/sounds/synths'
# OK
# lscp=# ADD DB_INSTRUMENTS RECURSIVE FILE_AS_DIR '/woodwinds' '/home/b08x/Studio/library/sounds/woodwinds'
# OK
# lscp=#
# INSTRUMENT NON_MODAL '/home/b08x/Studio/library/sounds/sfx/Earthbound_NEW.sf2
# ADD DB_INSTRUMENTS NON_MODAL '/collections' '/home/b08x/Studio/library/sounds/collections/oh_multi_preset.sf2'
