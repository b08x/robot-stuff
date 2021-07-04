#!/usr/bin/env ruby


require "tty-command"
require "tty-prompt"
require "highline"

hosts = {bender: "d8:d3:85:b2:dd:c5", ninjabot: "bc:5f:f4:0e:bb:b3"}

selection_prompt = TTY::Prompt.new
wol = TTY::Command.new

choices = selection_prompt.multi_select("select host to bother", hosts)


choices.each do |host_mac|
  selection_prompt.say "waking up hosts..."
  result = wol.run("wol #{host_mac}")
  if result.failed?
    puts "I either can't or I won't"
    next
  end
end
