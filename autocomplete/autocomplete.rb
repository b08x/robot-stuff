#!/usr/bin/env ruby

require 'pathname'
require 'refinements'

SAMPLES = File.join(ENV['HOME'], 'Library', 'Sounds', 'samples')
ARCO = File.join(SAMPLES, 'strings', 'bass', 'dsmolken_doublebass')

class AutoCompelete
  using Refinements::Hashes
  attr_accessor :samples
  def initialize
  end
end


sound_files = Dir.glob(ARCO + "/**/*flac")

samples = {:arco =>
  {:desc => "Samples From dmolken_doublebass" ,
   :prefix => "arco_",
   :samples => [ ],
  }
}

sound_files.each do |file|
  file = Pathname.new(file)
  file = file.sub_ext('').basename.to_s
  samples[:arco][:samples] << file
end

p samples
