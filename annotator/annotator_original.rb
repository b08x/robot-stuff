#!/usr/bin/env ruby

$LOAD_PATH.push File.expand_path(File.dirname(__FILE__) + '/lib')

APP_ROOT = File.expand_path(File.dirname(__FILE__))

#$ sonic-annotator -s vamp:vamp-example-plugins:fixedtempo:tempo > test.n3
#$ sonic-annotator -t test.n3 audio.wav -w csv --csv-stdout

require 'tty-command'
require "refinements"
require "refinements/hashes"
require "refinements/pathnames"


def to_midi(audiofile)
  cmd = TTY::Command.new(printer: :pretty)
  return cmd.run("/usr/local/bin/sonic-annotator -q -w midi --midi-basedir #{midifile_dir} -d vamp:pyin:pyin:notes #{audiofile}")
end

def get_tempo(audiofile)
  tempo = 0
  #adjust step size to something higher e.g 256 to get a more accurate reading
  profile = File.join("/home/b08x/Workspace/robot-stuff/autocomplete/fixedtempo.n3")
  cmd = TTY::Command.new(printer: :pretty)
  results = cmd.run("sonic-annotator -t #{profile} #{audiofile} -w csv --csv-stdout")

  tempo = results.out.split(",")[3].to_i.round(1)

  return tempo
end

def get_notes(audiofile)
  notes = []
  cmd = TTY::Command.new(printer: :pretty)
  profile = File.join("/home/b08x/Workspace/robot-stuff/autocomplete/pynotes.n3")
  results = cmd.run("/usr/local/bin/sonic-annotator -t #{profile} #{audiofile} -w csv --csv-stdout")

  results.out.split("\n").each do |line|
    notes << line.split(",").last
  end

  return notes
end

def sox_stats(file)
  file_info = {}
  cmd = TTY::Command.new
  results = cmd.run("sox '#{file}' -n stats", :err => :out)

  results.out.each_line do |x|
    if x =~ /Length/
      length = x.gsub(/Length s\s+/,'')
      file_info[:length] = length.to_f.round(2)
    end
    if x =~ /RMS lev dB/
      level = x.gsub(/RMS lev dB\s+/,'').split(" ").first
      file_info[:rms] = level.to_f
    end
    if x =~ /Pk lev dB/
      level = x.gsub(/Pk lev dB\s+/,'').split(" ").first
      file_info[:peak] = level.to_f
    end
  end

  return file_info
end

def set_tag(key,value,flacfile)
  #metaflac --set-tag=BPM=120 #{flacfile}
end

file = File.join("/mnt/backup/Library/Sounds/samples/instruments/piano/SalamanderGrandPianoV3_48khz24bit/48khz24bit/A5v16.wav")
#file = File.join("/mnt/backup/Library/Sounds/samples/loops/bass/david-lizmi_bass-fill-4_bass_one_shot_128_48khz.flac")
#file = File.join("/home/b08x/Studio/test/bpm160-Kick_0.wav")


a = get_notes(file)
#p a.out.split("\n")[1].split(",")
#p a.out.chomp.split("\n")[0]
p a
b = get_tempo(file)
p b

c = sox_stats(file)
p c
