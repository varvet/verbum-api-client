module Verbum
  module Api
    class Base
      BASE_URL = "http://api.verbumnovum.se/v1"
      TIMEOUT = 10
      OPEN_TIMEOUT = 5

      class << self
        def all(params = {})
          get(resource, params)
        end

        def find(id, params = {})
          if id.is_a?(Array)
            find(id.join(","))
          elsif id.present?
            get("#{resource}/#{id}", params)
          end
        end

        protected

        def connection
          @connection ||= Faraday.new(url: BASE_URL) do |config|
            config.adapter Faraday.default_adapter
          end
        end

        def resource
          name.demodulize.tableize
        end

        def attributes(*attributes)
          attributes.each do |attribute|
            define_method(attribute) do
              @data[attribute.to_s]
            end
          end
        end

        def associations(*associations)
          associations.each do |association|
            define_method(association) do
              "verbum/api/#{association.to_s.singularize}".classify.constantize.find(
                @data["links"][association.to_s]
              )
            end
          end
        end

        private

        def get(url, params)
          parse_response(
            connection.send(:get) do |request|
              request.url(url)
              request.params = params
              request.options[:timeout] = TIMEOUT
              request.options[:open_timeout] = OPEN_TIMEOUT
            end
          )
        rescue Faraday::Error::TimeoutError
          fail "Connection timed out"
        rescue Faraday::Error::ConnectionFailed
          fail "Connection failed"
        end

        def parse_response(response)
          data = JSON.parse(response.body)[resource]

          if data.is_a?(Array)
            data.map { |data| resource_from_data(data) }
          else
            resource_from_data(data)
          end
        end

        def resource_from_data(data)
          resource_name = name.demodulize.underscore.to_sym

          if Verbum::Api.wrappers.key?(resource_name)
            Verbum::Api.wrappers[resource_name].new(new(data))
          else
            new(data)
          end
        end
      end

      def initialize(data)
        @data = data
      end

      def id
        @data["id"]
      end

      def href
        @data["href"]
      end
    end
  end
end
