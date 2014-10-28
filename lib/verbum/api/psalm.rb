module Verbum
  module Api
    class Psalm < Base
      def self.resource
        "psalms"
      end

      def id
        @data["id"]
      end

      def title
        @data["title"]
      end

      def number
        @data["number"]
      end

      def href
        @data["href"]
      end

      def verses
        Verse.find(@data["links"]["verses"])
      end
    end
  end
end
