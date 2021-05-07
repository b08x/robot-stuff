#!/usr/bin/env ruby

require "pathname"
require "refinements"
require "refinements/hashes"
require "refinements/pathnames"
require "shellwords"

MUSIC="/mnt/bender/media/music_old"

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
    return Pathname(src_folder).files "**/*.{flac,wav,wma,m4a,ogg}"
  end

end
#http://www.andypatterns.com/index.php/blog/cloning-directories-in-ruby-using-hard-links/
module FileStuff
  module_function

  using Refinements::Pathnames

  #
  def shellescape(string)
    return Shellwords.escape(string)
  end
  # => returns the file name without an extension.
  def name(soundfile)
    return Pathname(soundfile).name
  end
  # => returns only the file extension.
  def ext(soundfile)
    return Pathname(soundfile).extname
  end

  def hardlink(soundfile)
    #hardlink to tmpfs
    #rieturn pathname to tmp file
    #folder,file = soundfile.split
    
    #ideall this is the artist folder
    #directory = folder.dirname.to_s
    #ideally this is the album folder
    #basename = folder.basename.to_s

    #tmpdir = Pathname.new(File.join('/tmp/organize/', basename))

    #unless tmpdir.exist?

      #Dir.mktmpdir(tmpdir.to_s.shellescape)

    #end

    #FileUtils.cp_lr(soundfile.cleanpath, tmpdir)
    soundfile.make_link("/tmp")
    return 
  end

end

module Wav
  module_function

  using Refinements::Pathnames

  def normalize
  end

end


# this will return a pathname object for every wav/flac sample
# found in the SAMPLES directory(recursively)
sounds = Globbing.for_files(MUSIC)

# take the full path of a file and split it
# this will create two pathname objects;
# one being the absolute path where the file
# acutally is and the other being the filename
# itself
#sounds.map! {|fullpath| fullpath.split}

sounds.each do |song|
  title = FileStuff.name(song)
  extension = FileStuff.ext(song)
  
  case extension
    when "flac"
      puts "#{title} is flac!" 
    when "wav"
      tmpfile = FileStuff.hardlink(song)

    when "mp3"
      puts "convert to ogg"
    when "m4a"
      puts "convert to ogg"
    when "ogg"
      puts "do noththing"
    end
end
