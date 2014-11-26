module Verbum
  module Api
    class Tag < Base
      def self.resource
        "tags"
      end

      def name
        @data["name"]
      end

      def psalms
        Psalm.find(@data["links"]["psalms"])
      end
    end
  end
end
