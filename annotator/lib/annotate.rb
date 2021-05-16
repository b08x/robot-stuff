#!/usr/bin/env ruby

require 'csv'
class Annotate
    def initialize(audiofile)
      super("run sonic-annotator: #{audiofile}")
      #@path = path.to_path.shellescape
      @path = Pathname.new(audiofile)
      @plugins = File.join(APP_ROOT, 'plugins')
    end

    def get_tempo
      profile = File.join(@plugins, 'fixedtempo.n3')
      cmd = TTY::Command.new
      results = cmd.run("sonic-annotator -q -t #{profile} #{@path} -w csv --csv-stdout")
      @tempo = results.out.split(",")[3].to_i.round(1)
    end

    def get_notes
      profile = File.join(@plugins, 'pynotes.n3')
      cmd = TTY::Command.new
      results = cmd.run("sonic-annotator -q -t #{profile} #{@path} -w csv --csv-stdout")

      CSV.parse(results.out.strip, :col_sep => ',') do |row|
        @notes << row.last
      end
    end

    def get_key
      profile = File.join(@plugins, 'keydetector.n3')
      cmd = TTY::Command.new
      results = cmd.run("sonic-annotator -q -t #{profile} #{@path} -w csv --csv-stdout")

      CSV.parse(results.out.strip, :col_sep => ',') do |row|
        @key = row.last
      end
    end

end
