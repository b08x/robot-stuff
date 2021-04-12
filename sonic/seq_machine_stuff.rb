# Welcome to Sonic Pi


# creates an array with 16 placeholders as nil
# convert nils to zeros https://stackoverflow.com/a/2527779
@seq1 = Array.new(16).map!{|x|x ?x:0}
@seq2 = Array.new(16).map!{|x|x ?x:0}
@seq3 = Array.new(16)
@seq4 = Array.new(16)

define :parse_sync_address do |address| # used to retrieve data which matched wild card in synced event
  v= get_event(address).to_s.split(",")[6]
  if v != nil
    return v[3..-2].split("/")
  else
    return ["error"]
  end
end



# copying this over to lib/sonicpi/setter_methods.rb
# leaving this here until I figure out where things will
# end up.


# cant modify an array here....have this somehow return something else....
generate_sequence = lambda {|array,bool,index| array.delete_at(index);
array.insert(index,bool)}

live_loop :seq1 do

  use_real_time
  # this will be either 1 or 0
  onoff = sync "/osc*/seq/r1/*"

  # this will be in a range from 1-16
  index = parse_sync_address("/osc*/seq/r1/*")[3].to_i

  print onoff
  print index

  print @seq1.ring.map.with_index {|x,i| puts x;puts i}


end
comment do
  generate_sequence[@seq1,0,4]
  generate_sequence[@seq1,0,8]
  generate_sequence[@seq1,0,0]
  generate_sequence[@seq1,0,1]
  generate_sequence[@seq1,0,2]
  generate_sequence[@seq1,0,3]
  generate_sequence[@seq2,1,8]
  generate_sequence[@seq2,1,0]
  generate_sequence[@seq2,1,1]
  generate_sequence[@seq2,1,2]
  generate_sequence[@seq2,1,9]
end

live_loop :seqtest do
  stop
  16.times do
    tick
    play 60, on: @seq1.ring.look
    #play 48, on: @seq2.ring.look
    sleep 0.25
  end
end
