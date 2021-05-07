#!/usr/bin/env ruby

require 'i3ipc'


@i3 = I3Ipc::Connection.new



p = spawn 'x42-meter'

sleep 1

print p

Process.detach(p)
@i3.command('[title="(?i)EBU R128 Meter"] move workspace 2, workspace 2, split h')

spawn 'carla'
