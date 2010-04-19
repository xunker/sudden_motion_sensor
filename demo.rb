require 'lib/sudden_motion_sensor'

100.times do
  x,y,z = SuddenMotionSensor.values
  puts "X: #{x}, Y: #{y}, Z: #{z}"
  sleep 0.1
end