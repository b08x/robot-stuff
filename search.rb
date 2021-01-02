#!/usr/bin/env ruby
#https://gist.github.com/d2cd2789d82284f5e72d82ce6160805c


require "tty-command"
require "tty-prompt"
require "shellwords"

FOLDERS = ['archive', 'documents', 'workspace']

#query = ARGV[0].shellescape

class Zim
  # @return [String]
  attr_accessor :command, :query

  def initialize(query)
    @command = TTY::Command.new
    @query = query
  end

  def self.search(fer)
    # cmd = TTY::Command.new

    results = @command.run("zim --search Notes '#{fer}'")

    return results
  end

  def self.open(page)
    # cmd = TTY::Command.new
    @command.run("zim Notes '#{page}'")
  end

end

search_prompt = TTY::Prompt.new

query = TTY::Prompt.new.ask("enter query", required: true, modify: :trim)

query = query.shellsplit

phrase = lambda {|x| x + " or"}

last_word = query.pop

complete_phrase = []

query.each {|term| complete_phrase << phrase[term] }

complete_phrase.append(last_word)

complete_phrase = complete_phrase.shelljoin


#
results = Zim.search(complete_phrase)

puts "#{results}"

# #
pages = results.out.split("\n")

prompt = TTY::Prompt.new
#
page = prompt.select("anything look good?", pages)
#
Zim.open(page.shellescape)



# set case insensitive, include hidden and be
# more accurate than quick
rga_options = ["-S", "--hidden", "--rga-accurate", "-e"]




elvi = ["archwiki", "bugzilla","github","google", "stack"]
