require 'rubygems'
require 'serialport'

# You'll need to have BlinkMCommunicator running on the Arduino first
# http://code.google.com/p/blinkm-projects/source/browse/trunk/blinkm_examples/arduino/BlinkMCommunicator/BlinkMCommunicator.pde?r=119

class Orb

  def initialize(port_str = "/dev/tty.usbserial-A7004Wav")
    puts "init"
    @port_str = port_str
    baud_rate = 19200 # the rate that BlinkMCommunicator uses
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE
    @sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
    @sp.sync = true
    sleep(2)  # give arduino a chance to restart
  end

  def close
    puts "closing"
    @sp.close
  end

 def stop
    puts "stop"
    @sp.putc 0x01
    @sp.putc 0x09
    @sp.putc 0x01
    @sp.putc 0x00
    @sp.putc 'o'
    @sp.flush
  end

  def fade_to_green
    puts "fading to green"
    fade_to(0x00, 0xff, 0x00)
  end

  def fade_to_red
    puts "fading to red"
    fade_to(0xff, 0x00, 0x00)
  end

 def fade_to(r,g,b)
    puts "fading to #{r} #{g} #{b}"
    @sp.putc 0x01
    @sp.putc 0x09
    @sp.putc 0x04
    @sp.putc 0x00
    @sp.putc 'c'
    @sp.putc r
    @sp.putc g
    @sp.putc b
    @sp.flush
  end

  def jump_to(r,g,b)
    puts "jumping to #{r} #{g} #{b}"
    @sp.putc 0x01
    @sp.putc 0x09
    @sp.putc 0x04
    @sp.putc 0x00
    @sp.putc 'n'
    @sp.putc r
    @sp.putc g
    @sp.putc b
    @sp.flush
  end

# more commands: https://docs.google.com/a/digital.cabinet-office.gov.uk/viewer?a=v&q=cache:MOr8-EHxtX0J:thingm.com/fileadmin/thingm/downloads/BlinkM_datasheet.pdf+&hl=en&gl=uk&pid=bl&srcid=ADGEEShDPqnr4ObeXUn-htewwt0Vh4Qy3g_3slvceihiCdL7dflR7wmnWdjtKVxo9j4tb-M22M7f8XbP_HJnHfMNQOIRP7U4o2oFiQIvD946EL-a5QM7Q9s5IWWmVeyvFcPr1Kvwavuj&sig=AHIEtbRh0idd7OCpCqO8KLjocJeQC51I9g

end

