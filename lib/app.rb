module App
  module_function

  autoload :WebSocket, 'app/websocket'
  autoload :Static, 'app/static'

  def call(env)
    return WebSocket.call(env) if Faye::WebSocket.websocket?(env)

    Static.call(env)
  end
end
