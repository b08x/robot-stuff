#!/usr/bin/env ruby

require "tty-command"
require "tty-prompt"
require "shellwords"

FOLDERS = ['archive', 'documents', 'workspace']

#query = ARGV[0].shellescape

class Search
  # @return [String]
  def bar; end

  def self.zim(phrase)

    zim = TTY::Command.new()
    output = zim.run("zim --search Notes #{phrase}")
  end
end



def search(fer)
  cmd = TTY::Command.new

  results = cmd.run("zim --search Notes #{fer}")

  return results
end

def open(page)
  cmd = TTY::Command.new
  cmd.run("zim Notes #{page}")
end

results = search("git")
#
pages = results.out.split("\n")

# [0].gsub(/\\/,'')
#
# page = page.shellescape
prompt = TTY::Prompt.new

page = prompt.select("anything look good?", pages)

open(page.shellescape)



# set case insensitive, include hidden and be
# more accurate than quick
rga_options = ["-S", "--hidden", "--rga-accurate", "-e"]




elvi = ["archwiki", "bugzilla","github","google", "stack"]
