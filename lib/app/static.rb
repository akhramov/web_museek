module App::Static
  module_function

  def call(env)
    static = Rack::File.new File.expand_path('../../dist', File.dirname(__FILE__))

    static.call(env)
  end
end
