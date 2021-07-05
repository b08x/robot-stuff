
def gitar01
  with_fx :reverb, room: 0.7, damp: 0.4 do
    with_fx :lpf, cutoff: 120 do
      with_fx :hpf, cutoff: 41 do
        with_fx :eq, pre_amp: 2.5, low_shelf: -0.8, low_shelf_note: 41, low_shelf_slope: 1, low: -0.2, low_note: 59, low_q: 0.8,
                     mid: 0.2, mid_note: 66, mid_q: 0.8,
                     high_shelf: -0.2, high_shelf_note: 124, high_shelf_slope: 1, high: 0, high_note: 105, high_q: 0.6 do

          live_audio :gitar01, input: 1
        end
      end
    end
  end
end

gitar01

# live_audio :gitar01, input: 1


# live_loop :scales do
#   with_fx :hpf, cutoff: 80 do
#     with_fx :echo, decay: 0.8, phase: 0.8 do
#       with_fx :gverb, room: 10, spread: 1, damp: 0.8 do
#         16.times do
#           with_fx :pan, pan: rrand(-0.5, 0.5) do
#             use_synth :mod_fm
#
#             with_fx :distortion, distort: 0.2 do
#               with_fx :ring_mod, freq: 42 do |ring|
#                 control ring, freq_slide: 0.1, freq: 52
#                 play scale(:d2, :blues_major, num_octaves: 2).choose, attack: 0.75, decay: 0.125, release: 0.125, amp: rand
#               end
#             end
#           end
#           sleep 1
#         end
#       end
#     end
#   end
# end

# live_loop :melody do
#
# use_synth :mod_sine
#
# if one_in(6)
#   use_transpose 2
# else
#   use_transpose 0
# end
#
with_fx :band_eq, amp: 0.5 do
  with_fx :lpf, cutoff: 47 do
      play_pattern_timed [:c2, :e2, :f2, :g2, :f2, :e2, :f2, :g2, :f2, :e2, :f2], [0.25, 0.25, 0.25, 1.5, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25], attack: 0, release: 0.2
  end
end
#
#
# end

# use_bpm 180
#
# with_fx :reverb, mix: 0.2, room: 1 do
#   live_loop :grain1 do
#     s = rrand(0, 0.7)
#     t = rrand(0.03, 0.3)
#     e = s + t
#     a = rrand(0.5, 1.0)
#     sample :guit_e_fifths, rate: -1.5, start: s, finish: e, attack: t/6.0, sustain: t/2.0, pan: rrand(-0.5, 0.5)
#     sleep t
#   end
#
#   live_loop :grain2 do
#     s = rrand(0, 0.7)
#     t = rrand(0.03, 0.2)
#     e = s + t
#     a = rrand(0.5, 1.0)
#     sample :guit_em9, rate: 1.5, start: s, finish: e, attack: t/6.0, sustain: t/2.0, pan: rrand(-0.5, 0.5)
#     sleep t
#   end
# end
