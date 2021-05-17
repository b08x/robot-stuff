#!/usr/bin/env ruby

require 'tempfile'
require 'pathname'
require 'fileutils'
require 'tty-command'
require 'csv'

IMPORT = File.join("/mnt/backup/Library/Sounds")

DEST = File.join(ENV['HOME'], 'Sounds')

PLUGINS = File.join(ENV['HOME'], 'Workspace', 'robot-stuff', 'annotator', 'plugins')

sourcefile = ARGV[0]
#sourcefile = "/mnt/backup/Library/Sounds/drumkits/DOUMBEK/Doum B head vel 4.wav"

if ARGV[0].nil?
  puts "no arguement"
  exit
end

class FileInfo
  attr_accessor :sourcepath, :filename, :extension,
                :basefolder, :destpath

  def initialize(file)
    @file = Pathname.new(file)
    @sourcepath = @file.to_path
    @filename = @file.basename
    @extension = @file.extname
    @basefolder = @file.relative_path_from(IMPORT).dirname
    @destpath = File.join(DEST, basefolder,filename)
  end
  #cmd = TTY::Command.new(printer: :pretty)


end

class AudioInfo < FileInfo
  attr_accessor :channels, :samplerate, :bitdepth, :encoding, :length,
                :rms, :peak
  
  def get_channels
    @channels = `soxi -c "#{@file}"`.strip.to_i
  end

  def get_samplerate
    @samplerate = `soxi -r "#{@file}"`.strip.to_i
  end

  def get_bitdepth
    @bitdepth = `soxi -p "#{@file}"`.strip.to_i
  end

  def get_encoding
    @encoding = `soxi -t "#{@file}"`.strip
  end

  def get_length
    @length = `soxi -D "#{@file}"`.strip.to_f.round(2)
  end

  def get_levels
    cmd = TTY::Command.new
    results = cmd.run("sox -V2 '#{@file}' -n stats", :err => :out)

    results.out.each_line do |x|
      if x =~ /RMS lev dB/
        level = x.gsub(/RMS lev dB\s+/,'').split(" ").first
        @rms = level.to_f
      end
      if x =~ /Pk lev dB/
        level = x.gsub(/Pk lev dB\s+/,'').split(" ").first
        @peak = level.to_f
      end
    end
  end

  def get_stats
    get_channels
    get_samplerate
    get_encoding
    get_bitdepth
    get_length
    get_levels
  end
end

class Annotate
  attr_accessor :tempo, :key, :notes
  
  def initialize(file)
    @source = file
    @notes = []
    @notes_in_hz = []
  end

  def get_tempo
    profile = File.join(PLUGINS, 'fixedtempo.n3')
    results = `sonic-annotator -q -t "#{profile}" -w csv --csv-stdout "#{@source}"`

    CSV.parse(results.strip, :col_sep => ',') do |row|
      @tempo = row.last
    end
  end

  def get_key
    profile = File.join(PLUGINS, 'keydetector.n3')
    results = `sonic-annotator -q -t "#{profile}" -w csv --csv-stdout "#{@source}"`

    CSV.parse(results.strip, :col_sep => ',') do |row|
      @key = row.last
    end
  end
  
  def get_notes_in_hz
    profile = File.join(PLUGINS, 'pynotes.n3')
    results = `sonic-annotator -q -t "#{profile}" "#{@source}" -w csv --csv-stdout`
    CSV.parse(results, :col_sep => ',') do |row|
      @notes_in_hz << row.last
    end
  end

  def get_notes
    profile = File.join(PLUGINS, 'silvetnotes.n3')
    results = `sonic-annotator -q -t "#{profile}" "#{@source}" -w csv --csv-stdout`
    CSV.parse(results, :col_sep => ',') do |row|
      @notes << row.last
    end
  end

  #def annotate
  #  get_notes
  #  get_key
  #  get_tempo
  #end
end

soundfile = AudioInfo.new(sourcefile)
soundfile.get_stats

annotate = Annotate.new(soundfile.sourcepath)
annotate.get_notes
annotate.get_notes_in_hz
annotate.get_key

if annotate.notes.count > 4
  annotate.get_tempo
end

p soundfile
p annotate


