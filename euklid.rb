osc_host = "localhost:2275/Carla"
use_osc "localhost", 2275

#toggle bypass
/1/set_active

#euklid
/1/set_parameter_value/1 0.0-7.0 #speed
0 = 1/2
1 = 1/4
2 = 1/6
3 = 1/8
4 = 1/12
5 = 1/16
6 = 1/24
7 = 1/32

/1/set_parameter_value/2 0.0-32.0 #steps

# beats/accents is a percentage of steps
# e.g. 16 steps | 16 beats (100%)
# e.g 16 steps | 8 beats (50%)
# e.g 16 steps | 8 accents (50%)
/1/set_parameter_value/3 0.0-100.0 #beats


/1/set_parameter_value/4 0.0-100.0 #rotate

/1/set_parameter_value/5 0.0-127.0 #velocity

/1/set_parameter_value/6 10.0-90.0 #duration

/1/set_parameter_value/7 21.0-108.0 #note

/1/set_parameter_value/8 21.0-108.0 # acc. note

/1/set_parameter_value/9 0.0-100.0 #accents

/1/set_parameter_value/10 0.0-100.0 #acc rotate

/1/set_parameter_value/11 0.0-127.0 #velocity

/1/set_parameter_value/12 10.0-90.0 #acc. duration
