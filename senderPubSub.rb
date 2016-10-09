#!/usr/bin/ruby
require "bunny"

conn = Bunny.new(:hostname=>"127.0.0.1")
conn.start

channel = conn.create_channel


#this creates a fanout exchange named logsly
exchange = channel.fanout('logsly')

if ARGV.empty?
  msg = "this is in place of the empty stdin"
else
  msg = ARGV.join(" ")
end

#publishing to the exchange named "exchange"
exchange.publish(msg)

puts "finished publishing the msg to the exchange. The subscriber processes will create a random queue and bind it to this exchange"



