module Configuration
  extend Dry::Configurable

  setting :museek do
    setting :socket do
      setting :address, ENV['MUSEEK_SOCKET_ADDRESS']
      setting :port, ENV['MUSEEK_SOCKET_PORT']
    end
    setting :password, ENV['MUSEEK_PASSWORD']
  end

  def self.method_missing(name)
    config.public_send name
  end
end
