module Verbum
  module Api
    class Verse < Base
      def self.resource
        "verses"
      end

      def id
        @data["id"]
      end

      def body
        @data["body"]
      end

      def href
        @data["href"]
      end

      def psalm
        Psalm.find(@data["links"]["psalm"])
      end
    end
  end
end
