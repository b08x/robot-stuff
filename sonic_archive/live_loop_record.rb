#example using new live_audio and buffer recording features in SP midi-alpha7 and midi_alpha8
#by Robin Newman, June 2017
use_bpm 120
r2=2**(1.0/12) #scale factor to increase pitch by 1 semitone
rb=[buffer[:b1,32],buffer[:b2,32],buffer[:b3,32],buffer[:b4,32]]



Track=1  #track number for recording (using 4 buffers here)
recording=true
#RECORDING
if recording then
  #metronome
  live_loop :bt do
    play 84,release: 0.05 #pulse every beat whist recording
    sleep 1
  end
  sleep 4 #one bar (4 beats) lead in
  ##| #RECORD LIVE SYNTH INPUT
  with_fx :record, buffer: rb[Track-1] do #record for 32 beats (duration of Frere Jaques)
    live_audio :fred
  end
else #playback mode
  ##| sample rb[0]
  ##| stop
  
  #PLAYBACK
  tr1=0 #transpose/bpm correctors for live_loops d and m
  tr2=0
  
  
  live_loop :d,auto_cue: false do    #this loop gives a drum track
    use_bpm 120*(r2**tr1) #correct bpm to suit sample transpose setting (allows for quicker rate)
    c=(ring 1,0,0,1,1,0,1,0)
    sample :bd_haus,amp: 0.5 if c.tick==1
    sleep 0.25
    if look== 4*32+4*8*3-1 #number of ticks on one complete pass of the 4 part round
      tr1+=1 # up semitone for next pass, so adjust correction
      tick_reset #reset tick for nexct pass
    end
    stop if tr1==4 #stop after 4 plays
  end
  
  live_loop :m,auto_cue: false do  #this loop sends midi to external synth which is fed back as live audio
    use_transpose tr2 #up a semitone each new iteration of the complete round
    use_bpm 120*(r2**tr2) #adjust the timing. Gets faster because of rpitch setting on samples
    c= octs(:c3,4).tick #pinched from Sam's bierhtday celebration video Plays octave Cs
    midi c,sustain: 1
    sleep 1
    if look== 32+8*3-1 #check if round has finished
      tr2+=1 #bmump transpose for next pass
      tick_reset #reset tick count
    end
    stop if tr2==4 #stop after 4 plays
  end
  
  sp=8.0 #number of beatsdelay between each paert of the round
  with_fx :gverb,room: 25 do
    in_thread do #put in thread so that live_audio below starts immediately
      4.times do |tr|
        sample rb[0],rpitch: tr,amp: 0.4,pan: 1
        sleep sp/(r2**tr) #reduce sleep time as rpitch setting increases tempo as side effect
        sample rb[1],rpitch: tr,amp: 0.6,pan: 0.33 #second part
        sleep sp/(r2**tr)
        sample rb[2],rpitch: tr,amp: 0.4,pan: -0.33 #third part
        sleep sp/(r2**tr)
        sample rb[3],rpitch: tr,amp: 0.8,pan: -1 #fourth part
        sleep 4*sp/(r2**tr) #wait for fourth part to complete
        tr+=1 #raise rpitch setting for next play-through of the round
      end #loop
    end #thread
    live_audio :fred #input from synth played by midi loop m added as live feed
  end #fx
end #if recording false