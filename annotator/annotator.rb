#!/usr/bin/env ruby


APP_ROOT = File.expand_path(File.dirname(__FILE__))

#$LOAD_PATH.push File.expand_path(APP_ROOT + '/lib')
#$ sonic-annotator -s vamp:vamp-example-plugins:fixedtempo:tempo > test.n3
#$ sonic-annotator -t test.n3 audio.wav -w csv --csv-stdout

Dir["#{File.expand_path(APP_ROOT, __FILE__)}/lib/"].each do |lib|
  p lib
  $:.unshift lib
end

#require 'annotate'
