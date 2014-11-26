module Verbum
  module Api
    class Verse < Base
      def self.resource
        "verses"
      end

      def body
        @data["body"]
      end

      def psalm
        Psalm.find(@data["links"]["psalm"])
      end
    end
  end
end
