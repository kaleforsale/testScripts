#!/usr/bin/ruby
require "bunny"

conn = Bunny.new(:hostname => "127.0.0.1")
conn.start

ch = conn.create_channel
q = ch.queue("clicks")

puts "waiting for messages from #{q.name}"

q.subscribe(:block=> true) do |delivery_info, properties, body|
  puts "[x] received: \n #{body}\n\n"

  puts "[x] info from delivery info:\n #{delivery_info}\n\n"
  puts "[x] info from properties:\n #{properties}\n\n"
end