module Verbum
  module Api
    class Author < Base
      def self.resource
        "authors"
      end

      def name
        @data["name"]
      end

      def authorships
        Authorship.find(@data["links"]["authorships"])
      end
    end
  end
end
