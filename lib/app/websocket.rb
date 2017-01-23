module App::WebSocket
  module_function

  autoload :Router, 'app/websocket/router'

  Router.draw_routes do
    route '/transfers', to: -> (data) { data }
  end

  def call(env)
    ws = Faye::WebSocket.new(env, [], extensions: [PermessageDeflate])

    ws.onopen = Router.subscribe
    ws.onmessage = Router.message
    ws.onclose = Router.unsubscribe

    ws.rack_response
  end
end
