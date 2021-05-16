#!/usr/bin/env ruby

require 'tty-command'

cmd = TTY::Command.new(pty: true, printer: :pretty)

BENDER=File.join("/mnt/bender")

objective = ARGV[0]

case objective
  when "mount"
    cmd.run("sudo mount bender:/b08x /mnt/bender/b08x")
    cmd.run("sudo mount bender:/srv/share /mnt/bender/share")
  when "umount"
    cmd.run("sudo umount /mnt/bender/share")
    cmd.run("sudo umount /mnt/bender/b08x")
end
