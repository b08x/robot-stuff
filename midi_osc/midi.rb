#!/usr/bin/env ruby
#
require 'midi-eye'

#@input = UniMIDI::Input.gets
#@output = UniMIDI::Output.gets

#MIDIMessage::ControlChange
#MIDIMessage::Controller
#MIDIMessage::Message

def panic
  16.times do |x|
    
    # all notes off
    #notes_off = MIDIMessage::ControlChange.new(x, 123, 0)

    # all sounds off
    sounds_off =  MIDIMessage::ControlChange.new(0, 120, 0)

    # send to all the midi outs
    outputs = UniMIDI::Output.all

    outputs.each do |output|
     #output.puts(notes_off)
     output.puts(sounds_off)
    end
  end
end

panic

