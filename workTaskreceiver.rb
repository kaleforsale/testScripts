#!/usr/bin/ruby
require "bunny"

conn = Bunny.new(:hostname => "127.0.0.1")
conn.start

ch = conn.create_channel

q = ch.queue("task_queue", :durable=> true)

# prefetching on a connection makes sure the worker only gets one message. rabbitmq will send the next message to another worker
# so if ALL workers are busy, the queue will FILL UP
ch.prefetch(1)
puts "waiting for a message"

begin
  q.subscribe(:manual_ack => true, :block=> true) do |delivery_info,  properties, body|
    puts "[x] received #{body}"
    # there should be some work done in this block--sql inserts
    sleep 1.0
    puts "[x] sql inserts are done"
    ch.ack(delivery_info.delivery_tag)

  end
rescue Interrupt => _
  puts "exiting the worker process"
  conn.close
end

