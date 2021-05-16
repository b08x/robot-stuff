#!/usr/bin/env ruby
# frozen_string_literal: true

class SoxStuff < AudioFile
  def initialize(path)
    super("Get sox stats: #{path}")
    @path = path
  end

  def stats
    cmd = TTY::Command.new
    results = cmd.run("sox '#{@path}' -n stats", :err => :out)

    results.out.each_line do |x|
      if x =~ /Length/
        length = x.gsub(/Length s\s+/,'')
        @sox_stats[:length] = length.to_f.round(2)
      end
      if x =~ /RMS lev dB/
        level = x.gsub(/RMS lev dB\s+/,'').split(" ").first
        @sox_stats[:rms] = level.to_f
      end
      if x =~ /Pk lev dB/
        level = x.gsub(/Pk lev dB\s+/,'').split(" ").first
        @sox_stats[:peak] = level.to_f
      end
    end
  end

end
