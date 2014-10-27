module Verbum
  module Api
    class Base
      class << self
        BASE_URL = "http://localhost:3000/v1"
        TIMEOUT = 10
        OPEN_TIMEOUT = 5

        def connection
          @connection ||= Faraday.new(url: BASE_URL) do |config|
            config.adapter Faraday.default_adapter
          end
        end

        def get(url)
          parse_response(
            connection.send(:get) do |request|
              request.url(url)
              request.options[:timeout] = TIMEOUT
              request.options[:open_timeout] = OPEN_TIMEOUT
            end
          )
        rescue Faraday::Error::TimeoutError
          fail "Connection timed out"
        rescue Faraday::Error::ConnectionFailed
          fail "Connection failed"
        end

        private

        def parse_response(response)
          JSON.parse(response.body)
        end
      end
    end
  end
end
