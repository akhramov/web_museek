# A simple router implementation
module App::WebSocket::Router
  extend self

  # Raised when specified route wasn't found
  class RouteNotFound < StandardError; end

  def draw_routes(&block)
    instance_eval(&block)

    lock!
  end

  # Register a route
  #
  # @example JSON echo server on '/transfers' endpoint
  #   App::WebSocket::Router.draw_routes do
  #     route '/transfers', to: -> (data) { data }
  #   end
  #
  # @param message_type [String] Path
  # @param to [#call] the object to be called. The object
  #   * Receives the payload parameter
  #   * Must return #to_h-able value
  #
  # @return [void]
  def route(message_type, to:)
    @_routes ||= {}

    @_routes[message_type] = to
  end

  def message
    lambda do |event|
      room = current_room(event)

      EventBus.publish(room, event.data)
    end
  end

  def subscribe
    lambda do |event|
      @_sockets ||= []
      @_sockets << event.current_target
    end
  end

  def unsubscribe
    lambda do |event|
      @_sockets.delete(event.current_target)
    end
  end

  private

  def current_room(event)
    event.current_target.env['REQUEST_PATH']
  end

  def lock!
    MuseekAdapter.init

    @_routes.keys.each do |room|
      EventBus.pubsub.subscribe(room)
      MuseekAdapter.subscribe(room)
    end

    EventBus.pubsub.on(:message) do |channel, payload|
      route = @_routes[channel]

      payload = JSON.parse(payload)

      @_sockets.each do |socket|
        socket.send route.call(payload).to_json
      end
    end
  rescue StandardError => e
    puts e.message
    binding.pry
  end
end
