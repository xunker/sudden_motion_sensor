require 'rubygems'
require "inline"  

class SuddenMotionSensor
  class << self  
    inline do |builder|  
      builder.add_compile_flags '-x objective-c', '-framework IOKit'  
      builder.include "<IOKit/IOKitLib.h>"      
      builder.c %q{  
        VALUE values(){  
  
          struct data {  
            signed short x;  
            signed short y;  
            signed short z;  
            char pad[34];  
          };  
  
          kern_return_t result;  
  
          mach_port_t masterPort;  
          IOMasterPort(MACH_PORT_NULL, &masterPort);  
          CFMutableDictionaryRef matchingDictionary = IOServiceMatching("SMCMotionSensor");  
            
          io_iterator_t iterator;  
          result = IOServiceGetMatchingServices(masterPort, matchingDictionary, &iterator);  
            
          if(result != KERN_SUCCESS) {  
            return rb_str_new2("Error");  
          }  
  
          io_object_t device = IOIteratorNext(iterator);  
          IOObjectRelease(iterator);  
          if(device == 0){  
            return rb_str_new2("Error");  
          }  
  
          io_connect_t dataPort;  
          result = IOServiceOpen(device, mach_task_self(), 0, &dataPort);  
          IOObjectRelease(device);  
  
          if(result != KERN_SUCCESS) {  
            return rb_str_new2("Error");  
          }  
  
          IOItemCount structureInputSize;  
          IOByteCount structureOutputSize;  
  
          struct data inputStructure;  
          struct data outputStructure;  
          structureInputSize = sizeof(struct data);  
          structureOutputSize = sizeof(struct data);  
  
          memset(&inputStructure, 1, sizeof(inputStructure));  
          memset(&outputStructure, 0, sizeof(outputStructure));  
  
          result = IOConnectMethodStructureIStructureO(  
            dataPort,  
            5,  
            structureInputSize,  
            &structureOutputSize,  
            &inputStructure,  
            &outputStructure  
          );  
  
          if(result != KERN_SUCCESS) {  
            return rb_str_new2("Error");  
          }  
  
          IOServiceClose(dataPort);  
  
          VALUE coords = rb_ary_new2(3);  
          rb_ary_store(coords, 0, INT2FIX(outputStructure.x));  
          rb_ary_store(coords, 1, INT2FIX(outputStructure.y));  
          rb_ary_store(coords, 2, INT2FIX(outputStructure.z));  
  
        return coords;  
        }  
      }  
    end  
  end  
  def values
    # returns [x,y,z] which are signed integers of the value of each axis.
    super
  end
end
