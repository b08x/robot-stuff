#!/usr/bin/env ruby

launch aubio as a seperate process

def forkoff(command)
  fork do
		exec(command)
	end
end

# set the threshold to 0.6 so as not to be so senstive
aubio -t 0.6 -j
