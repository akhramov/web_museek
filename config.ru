lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'json'
require 'socket'

require 'bundler'
Bundler.require

Faye::WebSocket.load_adapter('thin')

require 'app'
require 'museek_adapter'
require 'event_bus'
require 'configuration'

class Rack::Lint
  def call(env)
    @app.call(env)
  end
end

run App
