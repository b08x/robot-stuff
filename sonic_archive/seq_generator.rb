use_bpm 60
use_osc "192.168.41.145",9000 #ip address and port of TouchOSC (adjust)
use_osc_logging true
use_debug true
use_cue_logging true




# creates an array with 16 placeholders as nil
@seq1 = Array.new(16)
@seq2 = Array.new(16)
@seq3 = Array.new(16)
@seq4 = Array.new(16)

#TODO:
# cant modify an array here....have this somehow return something else....



# copying this over to lib/sonicpi/setter_methods.rb
# leaving this here until I figure out where things will
# end up.
generate_sequence = lambda {|array,bool,index| array.delete_at(index);
                                  array.insert(index,bool)}



live_loop :seq1 do
  use_real_time
  # this will be either 1 or 0
  onoff = sync "/osc*/seq/r1/*/1"

  # this will be in a range from 1-16
  index = parse_sync_address("/osc*/seq/r1/*/1")[3].to_i

  print onoff
  print index

end



DRUMKITS= "/home/b08x/Studio/library/sounds/drumkits/**"


live_loop :drums do
use_bpm 60
  #                1 e & a  2 e & a  3 e & a  4 e & a, 5 e & a
  # cymbals = bools(0,0,0,0, 0,1,0,1, 0,0,0,0, 0,1,0,0, 0,1,0,0)
  # hard    = bools(0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0)
  # soft    = bools(0,0,0,0, 0,0,0,1, 0,0,0,0, 0,0,0,0, 0,0,1,0)
  # kick    = bools(1,0,1,0, 0,0,0,0, 1,0,0,0, 0,0,0,0, 1,1,0,0)
  cymbals = spread(2,8)
  hard = spread(3,8)
  soft = spread(3,5)
  kick = spread(3,11)
  with_fx :reverb, room: 0.4, damp: 0.1, amp: 1.5 do
    16.times do
      tick
      if cymbals.look then
        sample DRUMKITS, "hats-pdl_v04", attack: 0.01, sustain: 0.2, release: 0.02, amp: 1
      else
        sample DRUMKITS, "hats-cld_v04", amp: 1 if one_in(8)
      end

      sample DRUMKITS, "drag-sd_v02", on: hard.tick, amp: 0.25


      sample DRUMKITS, "sd-flam_v06", on: soft.tick

      with_fx :lpf, cutoff: 100 do
        sample DRUMKITS, "bd_v04", attack: 0.001, on: kick.tick
      end
      sleep 0.25
    end
  end
end
