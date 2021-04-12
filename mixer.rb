#!/usr/bin/env ruby
require "tty-command"
require "tty-prompt"

WORKSPACE=File.join(ENV['HOME'], 'Studio', "sessions")

cmd = TTY::Command.new

# if quake is hidden, bring it to focus
cmd.run("guake --show")

# create new tab, start bash session in it
cmd.run('guake --new-tab --execute="/usr/bin/bash"')
# and then execute htop, renaming the tab to "htop"
cmd.run('guake --execute="/usr/bin/alsamixer" --rename-current-tab="alsamixer"')
