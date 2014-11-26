module Verbum
  module Api
    class Base
      BASE_URL = "http://localhost:3000/v1"
      TIMEOUT = 10
      OPEN_TIMEOUT = 5

      class << self
        def all
          get(resource)
        end

        def find(id)
          if id.is_a?(Array)
            find(id.join(","))
          else
            get("#{resource}/#{id}")
          end
        end

        protected

        def connection
          @connection ||= Faraday.new(url: BASE_URL) do |config|
            config.adapter Faraday.default_adapter
          end
        end

        def resource
          self.name.demodulize.tableize
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

        def parse_response(response)
          data = JSON.parse(response.body)[resource]

          if data.is_a?(Array)
            data.map { |d| new(d) }
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
