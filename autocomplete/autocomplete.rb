#!/usr/bin/env ruby

require "pathname"
require "refinements"
require "refinements/hashes"
require "refinements/pathnames"
require "shellwords"

SAMPLES = File.join(ENV['HOME'], 'Library', 'Sounds', 'samples')

ARCO = File.join(SAMPLES, 'strings', 'Bass', 'dsmolken_doublebass')


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
    return Pathname(src_folder).files "**/*.{flac,wav}"
  end

end

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
end




# class Collections
#   attr_accessor :samples
#
#   def initialize(src_folder)
#     src_folder = Pathname(src_folder)
#     return
#   end
#
#   def build_sample_collection_subset(sample_pack_path)
#
#     sample_pack_path = sample_pack_path.to_sym
#
#     @sample_pack = { sample_pack_path =>
#       {:desc => "Samples in that manipulate a certain way" ,
#        :prefix => "#{sample_pack_path}_",
#        :files => [ ]
#       }
#     }
#
#   end
#
#   def samplearray(foldername,file)
#
#       collection = foldername.to_sym
#
#       collection_array.samples[collection][:samples] << file.to_sym
#
#   end
# end



##-------------------------------------------------------------
# this will return a pathname object for every wav/flac sample
# found in the SAMPLES directory(recursively)
sounds = Globbing.for_files(SAMPLES)

# take the full path of a file and split it
# this will create two pathname objects;
# one being the absolute path where the file
# acutally is and the other being the filename
# itself
sounds.map! {|fullpath| fullpath.split}


# so now there is an array of arrays that contain two objects each....
#
#

# Pathname("/%placeholder%/samples/%placeholder%").gsub("%placeholder%", "test")
