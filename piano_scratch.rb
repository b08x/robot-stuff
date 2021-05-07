#!/usr/bin/env ruby

require 'tty-command'
require 'tty-prompt'
require 'shellwords'
require 'childprocess'
require 'i3ipc'

# open up a keys soundfont

# record wav/midi

class Launcher
  attr_accessor :command

  def initialize
    @commands = {}
  end

  def open(command)
    pid = spawn(command)

    @commands[command] = pid

    Process.detach(pid)

  end

  def print
    puts "#{@commands}"
  end

end

hey_launcher = Launcher.new

hey_launcher.open("x42-meter")
hey_launcher.print
hey_launcher.open("carla")
hey_launcher.print
#sleep 1
#Process.kill 'TERM', process
#Process.wait

# pid = spawn("x42-meter")
# Process.detach
