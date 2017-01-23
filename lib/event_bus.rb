module EventBus
  extend self
  # Forwardable complains about publish method...

  def publish(*args)
    provider.publish(*args)
  end

  def pubsub
    provider.pubsub
  end

  private

  def provider
    @_provider ||= EM::Hiredis.connect
  end
end
