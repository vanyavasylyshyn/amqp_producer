require 'bunny'

class Publisher
  class << self
    def publish(exchange, message = {})
      x = channel.fanout("producer.#{exchange}")
      x.publish(message.to_json)
    end

    def channel
      @channel ||= connection.create_channel
    end

    def connection
      @connection ||= Bunny.new(ENV['CLOUDAMQP_URL']).tap(&:start)
    end
  end
end