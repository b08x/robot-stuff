# Before running this file, first run helpers/play_helper.rb to load the pl function
set_mixer_control! hpf: 30

use_bpm 90
def pl(notes, sus: 0.5, rel: nil)
  rel ||= 1 - sus
  notes.each_slice(2) do |n,d|
    if d.respond_to?(:each) then # slur
      dtot = d.reduce(:+)
      synth = play n[0], sustain: sus * dtot, release: rel * dtot
      sleep d[0]
      d[1..-1].zip(n[1..-1]).each do |dd, nn|
        control synth, note: nn
        sleep dd
      end
    else
      play n, sustain: sus * d, release: rel * d
      sleep d
    end
  end
end
# pass it an array with pairs of note+duration:
#pl [:C, 1, :D, 1, :E, 1, :C, 1]

# you can optionally pass sustain and release values as a fraction of total duration:
when using control, e.g. to fade in ,

# slur notes by passing the notes and lengths inside arrays:
live_loop :test do
  use_synth :mod_beep
  with_fx :pan, pan: 0 do
pl [[:a3, :f2, :g3], [0.25, 0.5, 0.25]]
end
end
# you can also play chords:
#pl [[:E, :G], 1, [:F, :A], 1, chord(:G, :M), 2]
