# Welcome to Sonic Pi

def set_tempo(x)
  set :tempo, x
end

in_thread(name: :clock) do
  loop do
    cue :clock
    sleep 1
    puts current_beat_duration
  end
end

in_thread(name: :half, sync: :clock) do
  loop do
    cue :half
    sleep 0.5
  end
end

in_thread(name: :quarter, sync: :clock) do
  loop do
    cue :quarter
    sleep 0.25
  end
end


#defonce :sequences do
  # row 1
  set :seq1, Array.new(16).map!{|x|x ?x:0}
  # row 2
  set :seq2, Array.new(16).map!{|x|x ?x:0}
  # row 3
  set :seq3, Array.new(16).map!{|x|x ?x:0}
  # row 4
  set :seq4, Array.new(16).map!{|x|x ?x:0}
  # row 5
  set :seq5, Array.new(16).map!{|x|x ?x:0}
  # row 6
  set :seq6, Array.new(16).map!{|x|x ?x:0}
#end



def gen_seq_array(array,bool,index)
  generate_sequence = lambda {|array,bool,index| array.delete_at(index);
  array.insert(index,bool)}

  generate_sequence.call(array,bool,index)
end

in_thread(name: :oscthing) do

  live_loop :osc do
    use_real_time

    # this will be either 1 or 0
    onoff = sync "/osc*/2/seq/*/*"
    onoff = onoff.first
    #print onoff

    # this will be in a range from 1-6
    sequence = parse_sync_address("/osc*/2/seq/*/*")[3].to_i
    #puts "row: #{row}"

    # this will be in a range from 1-16
    index = parse_sync_address("/osc*/2/seq/*/*")[4].to_i
    index = (index - 1)
    #print index


    case sequence
    when 1
      puts "sequence1"
      a = get[:seq1].dup
      seqZ = gen_seq_array(a,onoff,index)
      set :seq1, seqZ
      print get[:seq1]
    when 2
      puts "sequence2"
      a = get[:seq2].dup
      seqZ = gen_seq_array(a,onoff,index)
      set :seq2, seqZ
      print get[:seq2]
    when 3
    when 4
    when 5
    when 6
    end

  end
end

use_synth :piano

def note1
  note = 52
  return note
end
def note2
  note = 66
  return note
end

#in_thread(name: :sound01) do

  live_loop :first do
    sync :quarter

    #16.times do
      tick
      sample :drum_heavy_kick, on: get[:seq1].ring.look
      #sleep 0.25
    #end
    puts "end of seq1"

  end

  live_loop :second do
    sync :quarter

    #16.times do
      tick
      sample :drum_snare_soft, amp: 1.5, on: get[:seq2].ring.look
      #sleep 0.25
    #end

    puts "end of seq2"
  end


#end
