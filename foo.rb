require 'eventmachine'

module MuseekAdapter
end

require_relative 'lib/museek_adapter/event_loop.rb'

a = MuseekAdapter::EventLoop.new

require 'museek_bindings'

a.on(MuseekBindings::Message::Transfer) do |payload|
  puts payload
end

a.run

A = a
