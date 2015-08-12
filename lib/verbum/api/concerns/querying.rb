module Verbum
  module Api
    module Querying
      TIMEOUT = 10
      OPEN_TIMEOUT = 5
      PROXY = nil

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def all(params = {})
          get(resource, params)
        end

        def find(id, params = {})
          if id.is_a?(Array)
            return [] if id.empty?
            Array(find(id.join(","), params))
          elsif id.present?
            get("#{resource}/#{id}", params)
          end
        end

        private

        def connection
          @connection ||= Faraday.new(url: Verbum::Api.base_url, proxy: PROXY) do |config|
            config.adapter Faraday.default_adapter
          end
        end

        def get(url, params = {})
          parse_response(
            connection.send(:get) do |request|
              request.url(url)
              request.params = params
              request.options[:timeout] = TIMEOUT
              request.options[:open_timeout] = OPEN_TIMEOUT
            end
          )
        rescue Faraday::Error::TimeoutError
          raise "Connection timed out"
        rescue Faraday::Error::ConnectionFailed
          raise "Connection failed"
        end

        def parse_response(response)
          parsed_response = JSON.parse(response.body)

          if parsed_response[resource].is_a?(Array)
            parsed_response[resource].map do |data|
              from_data(data, parsed_response["links"], parsed_response["linked"])
            end
          else
            from_data(parsed_response[resource], parsed_response["links"], parsed_response["linked"])
          end
        end
      end
    end
  end
end
