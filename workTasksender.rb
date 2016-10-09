#!/usr/bin/ruby

require "bunny"

conn = Bunny.new(:hostname=> "127.0.0.1")
conn.start

ch = conn.create_channel
q = ch.queue("task_queue", :durable=> true)

msg = ARGV.empty? ? "hello world-nothing on argv":ARGV.join(" ")

q.publish(msg, :persistent => true )
puts "finished sending message to the 'task_queue' queue. pretty much same as before"

