#!/usr/bin/env ruby
require "tty-command"
require "tty-prompt"

#WORKSPACE=File.join(ENV['HOME'], 'Workspace')

#repos = ['robot-stuff']

#prompt = TTY::Prompt.new

#choice = prompt.select("which git repo to view?",repos)

#repo = File.join(WORKSPACE,choice)

cmd = TTY::Command.new

# if quake is hidden, bring it to focus
cmd.run("guake --show")

# change into the direcory specified in DOTFILES then,
# create a new tab in guake, name it "git" and return
# the tab index
#result = cmd.run("guake -n 'googler' -g", chdir: repo)

# the tab index should be held in 'result.out'
# strip any whitespace characters and convert to integer
#tab_index = result.out.strip.to_i

# # split the tab vertically and run git commit in the current dir
cmd.run("guake -e 'googler'")
#
# # select the 'git' tab then select the terminal index
# # then run 'git diff'
# cmd.run("guake -s #{tab_index} -S 0 -e 'git commit -a'")
#
# # focus the current guake window
# cmd.run("swaymsg '[app_id=^guake] focus'")
