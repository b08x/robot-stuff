#!/usr/bin/env ruby
require "tty-command"
require "tty-prompt"

WORKSPACE=File.join(ENV['HOME'], 'Studio', "sessions")

cmd = TTY::Command.new

server = "jacktrip -s -n 4 -I -x -D"
client = "jacktrip -c ninjabot -n 4 -D"

# if quake is hidden, bring it to focus
cmd.run("guake --show")

# change into the direcory specified in DOTFILES then,
# create a new tab in guake, name it "git" and return
# the tab index
result = cmd.run("guake -n $PWD -r jacktrip -g", chdir: WORKSPACE)

# the tab index should be held in 'result.out'
# strip any whitespace characters and convert to integer
tab_index = result.out.strip.to_i

# split the tab vertically and run git commit in the current dir
cmd.run("guake --split-vertical -e '#{server}'", chdir: WORKSPACE)

# select the 'git' tab then select the terminal index
# then run 'git diff'
cmd.run("guake -s #{tab_index} -S 0 -e 'ssh soundbot01 #{client}'")

# focus the current guake window
cmd.run("swaymsg '[app_id=^guake] focus'")
