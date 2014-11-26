module Verbum
  module Api
    class Theme < Base
      def self.resource
        "themes"
      end

      def title
        @data["title"]
      end

      def psalms
        Psalm.find(@data["links"]["psalms"])
      end
    end
  end
end
