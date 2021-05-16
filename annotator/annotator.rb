#!/usr/bin/env ruby

$LOAD_PATH.push File.expand_path(File.dirname(__FILE__) + '/lib')

APP_ROOT = File.expand_path(File.dirname(__FILE__))

#$ sonic-annotator -s vamp:vamp-example-plugins:fixedtempo:tempo > test.n3
#$ sonic-annotator -t test.n3 audio.wav -w csv --csv-stdout

require 'tty-command'
require "refinements"
require "refinements/hashes"
require "refinements/pathnames"
require 'audiofile'
require 'soxstats'
require 'annotate'

def to_midi(audiofile)
  cmd = TTY::Command.new(printer: :pretty)
  return cmd.run("/usr/local/bin/sonic-annotator -q -w midi --midi-basedir #{midifile_dir} -d vamp:pyin:pyin:notes #{audiofile}")
end

def set_tag(key,value,flacfile)
  #metaflac --set-tag=BPM=120 #{flacfile}
end

file = File.join("/mnt/backup/Library/Sounds/samples/instruments/piano/SalamanderGrandPianoV3_48khz24bit/48khz24bit/A5v16.wav")
#file = File.join("/mnt/backup/Library/Sounds/samples/loops/bass/david-lizmi_bass-fill-4_bass_one_shot_128_48khz.flac")
#file = File.join("/home/b08x/Studio/test/bpm160-Kick_0.wav")

d = Annotate.new(file)

d.stats
if onsets <= 1
  skip tempo
end
d.tempo
d.notes
p d
