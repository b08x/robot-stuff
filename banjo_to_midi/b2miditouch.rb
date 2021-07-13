#!/usr/bin/env ruby
#
require 'midi-eye'

@input = UniMIDI::Input.gets
@output = UniMIDI::Output.gets

scale_info = MIDIEye::Listener.new(@input)

scale_info.listen_for do |midi_event|
  message = midi_event[:message]
  p message
end

p "Control-C to quit..."

scale_info.run
