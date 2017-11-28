module Verbum
  module Api
    module Error
      class ConnectionTimedOut < RuntimeError; end
      class ConnectionFailed < RuntimeError; end
      class NotFound < RuntimeError; end
    end

    module Querying
      TIMEOUT = 10
      OPEN_TIMEOUT = 5
      PROXY = nil

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def all(params = {})
          merged_params = params.merge(Verbum::Api.default_parameters)
          get(resource, merged_params)
        end

        def find(id, params = {})
          merged_params = params.merge(Verbum::Api.default_parameters)
          if id.is_a?(Array)
            return [] if id.empty?
            Array(find(id.join(","), merged_params))
          elsif id.present?
            get("#{resource}/#{id}", merged_params)
          end
        end

        private
        def connection
          @connection ||= Faraday.new(url: Verbum::Api.base_url, proxy: PROXY) do |config|
            config.adapter Faraday.default_adapter
          end
        end

        def get(url, params = {})
          with_caching(url, params) do
            response = connection.send(:get) do |request|
              request.url(url)
              request.params = params
              request.options[:timeout] = TIMEOUT
              request.options[:open_timeout] = OPEN_TIMEOUT
            end

            case response.status
            when 404
              fail Error::NotFound
            when 200
              parse_response response
            end
          end
        rescue Faraday::Error::TimeoutError
          raise Error::ConnectionTimedOut
        rescue Faraday::Error::ConnectionFailed
          raise Error::ConnectionFailed
        end

        def parse_response(response)
          parsed_response = JSON.parse(response.body)
          if parsed_response[resource].is_a?(Array)
            parsed_response[resource].map do |data|
              from_data(data, parsed_response["links"], parsed_response["linked"], parsed_response["meta"])
            end
          else
            from_data(parsed_response[resource], parsed_response["links"], parsed_response["linked"])
          end
        end
      end
    end
  end
end
