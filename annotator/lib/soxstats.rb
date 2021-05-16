#!/usr/bin/env ruby
# frozen_string_literal: true

class SoxStuff < AudioFile
  def initialize(audiofile)
    #super("Get sox stats: #{audiofile}")
    @path = audiofile.to_path
  end

  def get_channels
    @sox_stats[:channels] = `soxi -c "#{@path}"`.strip.to_i
  end

  def get_samplerate
    @sox_stats[:samplerate] = `soxi -r "#{@path}"`.strip.to_i
  end

  def get_bitdepth
    @sox_stats[:bitdepth] = `soxi -p "#{@path}"`.strip.to_i
  end

  def get_encoding
    @sox_stats[:encoding] = `soxi -t "#{@path}"`.strip
  end

  def get_length
    @sox_stats[:length] = `soxi -D "#{@path}"`.strip.to_f.round(2)
  end

  def get_levels
    cmd = TTY::Command.new
    results = cmd.run("sox -V2 '#{@path}' -n stats", :err => :out)

    results.out.each_line do |x|
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

  # def get_stats
  #   get_channels
  #   get_samplerate
  #   get_bitdepth
  #   get_encoding
  #   get_length
  #   get_levels
  # end

end
