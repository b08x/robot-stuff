#!/usr/bin/env ruby

class Annotate < SoxStuff
    def initialize(path)
      super("run sonic-annotator: #{path}")
      @path = path
      @plugins = File.join(APP_ROOT, 'plugins')
    end

    def tempo
      profile = File.join(@plugins, 'fixedtempo.n3')
      cmd = TTY::Command.new
      results = cmd.run("sonic-annotator -t #{profile} #{@path} -w csv --csv-stdout")
      @tempo = results.out.split(",")[3].to_i.round(1)
    end

    def notes
      profile = File.join(@plugins, 'pynotes.n3')
      cmd = TTY::Command.new
      results = cmd.run("sonic-annotator -t #{profile} #{@path} -w csv --csv-stdout")
      results.out.split("\n").each do |line|
        @notes << line.split(",").last
      end
    end



end
