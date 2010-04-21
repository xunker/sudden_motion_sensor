require 'rubygems'

spec = Gem::Specification.new do |s| 
  s.name = "sudden_motion_sensor"
  s.version = "1.0.0"
  s.date = %q{2010-04-16}
  s.author = "Matthew Nielsen"
  s.email = "xunker@pyxidis.org"
  s.homepage = "http://n4k3d.com/code/sudden_motion_sensor/"
  s.platform = Gem::Platform.new ('universal-darwin')
  s.summary = "Reads data from Macbook Sudden Motion Sensor"
  s.description = "Read orientation and acceleration data from the Sudden Motion Sensor inside many Apple Macbook and Macbook Pro laptops."
  s.files = [ "README", "Changelog", "LICENSE", "demo.rb", "lib/sudden_motion_sensor.rb"]
  s.require_path = "lib"
  s.autorequire = "name"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.add_dependency("RubyInline", ">= 3.8.4")
end
