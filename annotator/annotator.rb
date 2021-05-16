#!/usr/bin/env ruby


APP_ROOT = File.expand_path(File.dirname(__FILE__))

$LOAD_PATH.push File.expand_path(APP_ROOT + '/lib')
#$ sonic-annotator -s vamp:vamp-example-plugins:fixedtempo:tempo > test.n3
#$ sonic-annotator -t test.n3 audio.wav -w csv --csv-stdout

require 'tty-command'
require "refinements"
require "refinements/hashes"
require "refinements/pathnames"
require 'audiofile'
require 'soxstats'
require 'annotate'

module Globbing
  module_function

  using Refinements::Hashes
  using Refinements::Pathnames

  # => returns a pathname object for each folder in the
  # given source
  def for_folders(src_folder)
    return Pathname(src_folder).directories "**/*"
  end

    # => returns files within a given folder
  def for_files(src_folder)
    return Pathname(src_folder).files "**/*.{flac,wav,ogg,mp3,wma,m4a}"
  end

  def for_ogg(src_folder)
    return Pathname(src_folder).files "**/*.{ogg}"
  end

  def for_flac(src_folder)
    return Pathname(src_folder).files "**/*.{flac}"
  end

  def for_wav(src_folder)
    return Pathname(src_folder).files "**/*.{wav}"
  end

end

def to_midi(audiofile)
  cmd = TTY::Command.new(printer: :pretty)
  return cmd.run("/usr/local/bin/sonic-annotator -q -w midi --midi-basedir #{midifile_dir} -d vamp:pyin:pyin:notes #{audiofile}")
end

def set_tag(key,value,flacfile)
  #metaflac --set-tag=BPM=120 #{flacfile}
end

#file = File.join("/mnt/backup/Library/Sounds/samples/instruments/piano/SalamanderGrandPianoV3_48khz24bit/48khz24bit/A5v16.wav")
#file = File.join("/mnt/backup/Library/Sounds/samples/loops/bass/david-lizmi_bass-fill-4_bass_one_shot_128_48khz.flac")
#file = File.join("/home/b08x/Studio/test/bpm160-Kick_0.wav")
IMPORT = "/mnt/backup/Library/Sounds/samples/"
sounds = Globbing.for_files(IMPORT)

sounds[0..20].each do |sound|
  #parent = sound.relative_path_from(IMPORT).dirname
  d = AudioFile.new(sound)
  e = SoxStuff.new(sound)
  p e.get_channels
  #d.parent = parent
  p d.fullpath
  p d.parent
  p d
end
