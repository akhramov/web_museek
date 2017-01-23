class MuseekAdapter::EventLoop
  def initialize
    @_listeners = {}

    @_socket = TCPSocket.new Configuration.museek.socket.address, Configuration.museek.socket.port
  end

  def run
    Thread.new do
      loop do
        break if @_stop

        length = @_socket.read(4).unpack('L').first
        code = @_socket.read(4).unpack('L').first
        message = @_socket.read(length - 4)

        puts code

        if code == 1
          puts "received code #{code}"
          message = MuseekBindings::Message::Challenge.new(data: message)

          pass = 'lorem'
          login = MuseekBindings::Message::Login.new(challenge: message.challenge, password: pass)

          @_socket.write(login.to_binary)
        end

        if code == 1281
          foo = MuseekBindings::Message::Transfer.new(data: message)
          @_listeners[foo.class].call(JSON(foo.to_h(methods: [:state])))
        end
      end
    end
  end

  def on(type, &block)
    return if @_listeners.key?(type)

    @_listeners[type] = block
  end

  def stop
    @_stop = true
  end

  private

  def JSON(hash)
    Hash[hash.to_h.map { |(k, v)| [k, v.is_a?(String) ? v.force_encoding('UTF-8') : v] }].to_json
  end
end
