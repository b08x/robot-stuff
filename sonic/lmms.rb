set_mixer_control! hpf: 21

live_loop :noise do
  use_synth :pnoise
  play 30, amp: 0.0001, attack: 0.75, release: 0.25
  sleep 1
end


with_fx :eq, low_shelf: 0, low_shelf_note: 21, low_shelf_slope: 0.1, low: 0, low_note: 28, low_q: 0.8,
             mid: 0, mid_note: 66, mid_q: 0.8,
             high: 0, high_note: 105, high_q: 0.6,
             high_shelf: 0, high_shelf_note: 124, high_shelf_slope: 0.5, pre_amp: 2 do






              live_audio :lmms, stereo: true, input: 1








end #end of eq fx
