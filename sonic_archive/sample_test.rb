
live_loop :noise do
  play 30, amp: 0.01, attack: 0.75, release: 0.25
  sleep 1
end

sample808 = "/home/b08x/studio/resources/samples/drums/drumkits/Classic-808"

live_loop :ebeat do

#wtih rlpf between 30-45 will produce deep thumps
#45 and and above and you start to get more rubber bouncy ball like
  with_fx :rlpf, cutoff: 45 do
    sample SAMPLES, "808_Kick_long"
  end
  sleep 1
end



# def eightoheight(rate=1)
#
#   with_fx :band_eq, freq: 44, res: 0.1, db: 20 do
#     sample :bd_808, pre_amp: 1.5, lpf: 40, rate: rate
#   end
#
# end
#
# live_loop :heartbeat do
#   sync :ambi_pia
#   2.times do
#     eightoheight
#     sleep 0.25
#   end
# end
