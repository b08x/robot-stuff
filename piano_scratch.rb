#!/usr/bin/env ruby

require 'tty-command'
require 'tty-prompt'
require 'shellwords'

# open up a keys soundfont

# record wav/midi

class Launcher
  attr_accessor :command

  def initialize
    @command = TTY::Command.new
  end

  def open(app)
    @command.run(app)
  end
end

hey_launcher = Launcher.new

hey_launcher.open("kitty")
