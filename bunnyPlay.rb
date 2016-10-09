#!/usr/bin/ruby

require "bunny"
# CCQ connection-channel-queue

conn = Bunny.new(:hostname => "127.0.0.1")   #tcp connection
conn.start

channel = conn.create_channel   #ampq channel/almost like a virtual connection

# queues are idempotent--will only be created if it doesn't already exist
queue = channel.queue("clicks")

channel.default_exchange.publish("hello world!", :routing_key => queue.name)
puts '[x]  sent hello world'

conn.close


