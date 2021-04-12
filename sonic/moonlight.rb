use_bpm 45


live_loop :riff do

  4.times do
    play_pattern_timed [:gs2, :cs3, :e3], [0.25], release: 0.25
  end

  4.times do
    play_pattern_timed [:a2, :cs3, :e3], [0.25], release: 0.25
  end

  2.times do
  play_pattern_timed [:a2, :d3, :fs3], [0.25], release: 0.25
  end

  2.times do
  play_pattern_timed [:gs2, :c3, :fs3], [0.25], release: 0.25
  end

end





live_loop :undertones do

  with_fx :rlpf, cutoff: 70 do
    play_pattern_timed [:e2, :g2, :e2, :b1], [1], attack: 0.75, release: 0.25
    play_pattern_timed [:e2, :g2, :fs2], [1, 1, 2], attack: 0.75, release: 0.25
    play_pattern_timed [:e2, :g2, :fs2, :b1], [1], attack: 0.75, release: 0.25
    play_pattern_timed [:e2, :g2, :e2], [1, 1, 2], attack: 0.75, release: 0.25
  end


end



2.times do
  play_pattern_timed [:a2, :cs3, :e3], [0.5], attack: 0.25, release: 0.25
end

2.times do
  play_pattern_timed [:a2, :d3, :fs3], [0.5], attack: 0.25, release: 0.25
end


2.times do
  play_pattern_timed [:gs2, :c3, :fs3], [0.5], attack: 0.25, release: 0.25
end

play_pattern_timed [:gs2, :cs3, :e3], [0.5], attack: 0.25, release: 0.25

play_pattern_timed [:gs2, :cs3, :ds3], [0.5], attack: 0.25, release: 0.25

play_pattern_timed [:fs2, :c3, :ds3], [0.5], attack: 0.25, release: 0.25
