#!/usr/bin/env ruby

oscsend localhost 9090 '/strip/master/C*%20Eq4p%20-%204-band%20parametric%20equaliser/a.f%20(Hz)/unscaled' f 1400

oscsend localhost 11884 'Non-Mixer/strip/Unnamed/Gain/Gain%20(dB)/unscaled' f 0.8

# toggle mute on
oscsend localhost 15816 'Non-Mixer/strip/master/Gain/Mute' f 1

# toggle mute off
oscsend localhost 15816 'Non-Mixer/strip/master/Gain/Mute' f 0

oscsend localhost 15816 'Non-Mixer/strip/mixxx/AMB%20order%201%2C1%20stereo%20panner/Width/unscaled' f 85.0
oscsend localhost 15816 'Non-Mixer/strip/mixxx/AMB%20order%201%2C1%20stereo%20panner/Elevation/unscaled' f 85.0
oscsend localhost 15816 'Non-Mixer/strip/mixxx/AMB%20order%201%2C1%20stereo%20panner/Azimuth/unscaled' f 85.0

oscsend localhost 19927 'Non-Mixer/strip/hydrogen/AMB%20order%201%2C1%20stereo%20panner/Width/unscaled' f 85.0
oscsend localhost 19927 'Non-Mixer/strip/hydrogen/AMB%20order%201%2C1%20stereo%20panner/Elevation/unscaled' f 85.0
oscsend localhost 19927 'Non-Mixer/strip/hydrogen/AMB%20order%201%2C1%20stereo%20panner/Azimuth/unscaled' f 85.0

oscsend localhost 15816 'Non-Mixer/strip/sonic/AMB%20order%201%2C1%20rotator/Angle/unscaled' f 0.0

oscsend localhost 11884 'Non-Mixer/strip/sonic/AMB%20order%201%2C1%20stereo%20panner/Elevation/unscaled' f 0.0
oscsend localhost 11884 'Non-Mixer/strip/sonic/AMB%20order%201%2C1%20stereo%20panner/Azimuth/unscaled' f 45.0

oscsend localhost 11884 'Non-Mixer/strip/Unnamed/AMB%20order%201%2C1%20stereo%20panner/Elevation/unscaled' f 0.0
oscsend localhost 11884 'Non-Mixer/strip/hydrogen/AMB%20order%201%2C1%20stereo%20panner/Azimuth/unscaled' f 45.0
