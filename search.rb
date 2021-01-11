#!/usr/bin/env ruby
#https://gist.github.com/d2cd2789d82284f5e72d82ce6160805c


require "tty-command"
require "tty-prompt"
require "shellwords"

FOLDERS = ['archive', 'documents', 'workspace']


class Zim

  attr_accessor :command, :query

  def initialize(query)
    @command = TTY::Command.new
    @query = query.shellsplit
  end

  def assemble(terms)
    last_word = terms.pop
    terms.map {|term| term + " or"}.append(last_word)
    return fer
  end


  # @return [String]
  def self.search(fer)
    fer = assemble(fer)

    results = @command.run("zim --search Notes '#{fer}'")
    return results
  end

  def self.open(page)
    @command.run("zim Notes '#{page}'")
  end

end


# search phrase(formerly known as complete phrase)
# phrase
# query
# results
# term
# subject = what
#

module Query
  module_function

  def parse(subject)
    terms = query.shellsplit
    return terms
  end

end

subject = TTY::Prompt.new.ask("What are you looking for?", required: true, modify: :trim)

terms = Query.parse(subject)
