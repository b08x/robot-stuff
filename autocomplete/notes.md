#

:arco => {
  :desc => "Samples From dmolken_doublebass",
  :prefix => "arco_",
  :samples => [
    :ambi_soft_buzz,
    :ambi_swoosh,
    :ambi_drone,
    :ambi_glass_hum,
    :ambi_glass_rub,
    :ambi_haunted_hum,
    :ambi_piano,
    :ambi_lunar_land,
    :ambi_dark_woosh,
    :ambi_choir,
    :ambi_sauna
    ]
},

----------------

#!/usr/bin/env ruby

require "pathname"
require "refinements"
require "refinements/hashes"
require "refinements/pathnames"
require "shellwords"

SAMPLES = File.join(ENV['HOME'], 'Library', 'Sounds', 'samples')

ARCO = File.join(SAMPLES, 'strings', 'bass', 'dsmolken_doublebass')


module Globbing
  module_function

  using Refinements::Hashes
  using Refinements::Pathnames

  # => returns a pathname object for each folder in the
  # given source
  def for_folders(src_folder)
    folders = Pathname(src_folder).directories "**/*"
    return folders
  end

    # => returns files within a given folder
  def for_files(src_folder)
    files = Pathname(src_folder).files "**/*.{flac,wav}"
    return files
  end

end


# => if given a string with spaces or special characters
# shellesacape will fill in escape characters where they
# need to be
def shellescape(string)
  string.shellescape
  return
end
# => returns the file name without an extenstion.
def for_filename(soundfile)
  soundfile = Pathname(soundfile).name
  return
end

def build_sample_collection_subset(sample_pack_path)

  sample_pack_path = sample_pack_path.to_sym

  @sample_pack = { sample_pack_path =>
    {:desc => "Samples in that manipulate a certain way" ,
     :prefix => "#{sample_pack_path}_",
     :files => [ ]
    }
  }

end

class Collections
    attr_accessor :samples

  def initialize(src_folder)
    src_folder = Pathname(src_folder)
    return
  end





  # => returns a Pathname object
  #def returnpathobject(string)
  #  pathobject = Pathname.new(string)
  #  return
  #end

end

def samplearray(foldername,file)

    collection = foldername.to_sym

    **

    ion_array.samples[collection][:samples] << file.to_sym

end

##-------------------------------------------------------------

class Something
  def method

  end

# this will return a pathname object for every wav/flac sample
# found in the SAMPLES directory(recursively)
sounds = Globbing.for_files(SAMPLES)

# take the full path of a file and split it
# this will create two pathname objects;
# one being the absolute path where the file
# acutally is and the other being the filename
# itself
sounds.map! {|fullpath| fullpath.split}

sounds.map {|x,y| p y.extname}
# so now there is an array of arrays that contain two objects each....
#
#

Pathname("/%placeholder%/samples/%placeholder%").gsub("%placeholder%", "test")
