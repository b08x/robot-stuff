#!/usr/bin/env ruby

require 'tty-command'
require 'tty-prompt'
require 'shellwords'
require 'childprocess'


# open up a keys soundfont

# record wav/midi

class Launcher
  attr_accessor :process

  def initialize(*cmd)
    @process = ChildProcess.build(*cmd)
    #@process.io.inherit!
  end

  def cwd(cwd)
    @process.cwd = cwd
  end

  def start
    @process.start
  end
end

#hey_launcher = Launcher.new("terminator", "-e", "htop")




# puts process
# sleep 1
# Process.wait
# Process.kill 'TERM', process
