module Verbum
  module Api
    class Base
      class << self
        def base_url
          "http://localhost:3000/v1"
        end

        def connection
          @connection ||= Faraday.new(url: base_url) do |config|
            config.adapter Faraday.default_adapter
            config.response :logger
          end
        end

        def get(url)
          connection.send(:get) do |request|
            request.url(url)
            request.options[:timeout]      = 10
            request.options[:open_timeout] = 5
          end
        rescue Faraday::Error::TimeoutError
          fail "Connection timed out"
        rescue Faraday::Error::ConnectionFailed
          fail "Connection failed"
        end
      end
    end
  end
end
