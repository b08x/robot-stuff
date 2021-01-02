#!/usr/bin/env ruby
#https://gist.github.com/d2cd2789d82284f5e72d82ce6160805c


require "tty-command"
require "tty-prompt"
require "shellwords"

FOLDERS = ['archive', 'documents', 'workspace']

#query = ARGV[0].shellescape

class Zim

  attr_accessor :command, :query

  def initialize(query)
    @command = TTY::Command.new
    @query = query
  end

  # @return [String]
  def self.search(fer)
    results = @command.run("zim --search Notes '#{fer}'")
    return results
  end

  def self.open(page)
    @command.run("zim Notes '#{page}'")
  end

end

search_prompt = TTY::Prompt.new

query = TTY::Prompt.new.ask("enter query", required: true, modify: :trim)

# split the query into an array of strings
query = query.shellsplit

# append or operator to query.item
phrase = lambda {|x| x + " or"}

# we don't want to add an operator after the last
# so we pop it out of the array and assign it
last_word = query.pop

# what will be the reassmebled query
complete_phrase = []

# for each word in the query, pass it through
# the lambda function to append "or"
query.each {|term| complete_phrase << phrase[term] }

# after all that, add the last word
complete_phrase.append(last_word)

# take complete_phrase array and join
# it back up as a string
complete_phrase = complete_phrase.shelljoin

# pass the phrase to the Zim search class
results = Zim.search(complete_phrase)

puts "#{results}"

# put the pages found by Zim in array
pages = results.out.split("\n")

prompt = TTY::Prompt.new
# prompt to select page(s) to open
page = prompt.select("anything look good?", pages)
# pass the selection to the Zim.open function
Zim.open(page.shellescape)



# set case insensitive, include hidden and be
# more accurate than quick
rga_options = ["-S", "--hidden", "--rga-accurate", "-e"]




elvi = ["archwiki", "bugzilla","github","google", "stack"]
