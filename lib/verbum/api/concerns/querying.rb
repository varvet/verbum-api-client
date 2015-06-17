module Verbum
  module Api
    module Querying
      BASE_URL = "http://api.verbumnovum.se/v1"
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

        def get(url, params = {})
          parse_response(
            APICache.get("#{BASE_URL}/#{url}")
          )
        end

        def parse_response(response)
          parsed_response = JSON.parse(response)

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
