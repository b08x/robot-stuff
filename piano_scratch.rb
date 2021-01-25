#!/usr/bin/env ruby

require 'tty-command'
require 'tty-prompt'
require 'shellwords'
require 'childprocess'


# open up a keys soundfont

# record wav/midi

class Launcher
  attr_accessor :command

  def initialize
    @command = TTY::Command.new(pty: true)
  end

  def open(app)
    pid = fork do
        exec(app)
    end
  end
end

hey_launcher = Launcher.new

process = hey_launcher.open("kitty")


puts process
sleep 1
Process.wait
Process.kill 'TERM', process
