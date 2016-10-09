#!/usr/bin/ruby

require "bunny"

conn = Bunny.new(:hostname => "127.0.0.1")
conn.start

ch = conn.create_channel

#identify and get the exchange, named 'logsly'
x = ch.fanout('logsly')

#create a temporary queue to bind to 'logsly' exchange
queue = ch.queue("", :exclusive=>true)

queue.bind(x)

begin
  queue.subscribe(:block=>true) do |delivery_info, properties, body|
    puts "[x] #{body}"
  end
rescue Interrupt => _
  ch.close
  conn.close
end

