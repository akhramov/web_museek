module MuseekAdapter
  extend self

  autoload :EventLoop, 'museek_adapter/event_loop'
  autoload :Types, 'museek_adapter/types'

  def init
    server_loop.run
  end

  def subscribe(room)
    type = Types[room]

    return unless type

    server_loop.on(type) do |payload|
      EventBus.publish(room, payload)
    end
  end

  private

  def server_loop
    @_server_loop ||= EventLoop.new
  end
end
