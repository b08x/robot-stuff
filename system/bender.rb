#!/usr/bin/env ruby

require 'tty-command'

cmd = TTY::Command.new(pty: true, printer: :pretty)

BENDER=File.join("/mnt/bender")

objective = ARGV[0]

case objective
  when "mount"
    cmd.run("sudo mount bender:/storage01 /mnt/bender/storage01")
    cmd.run("sudo mount bender:/storage02 /mnt/bender/storage02")
  when "umount"
    cmd.run("sudo umount /mnt/bender/storage01")
    cmd.run("sudo umount /mnt/bender/storage02")
end
