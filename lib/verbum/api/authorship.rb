module Verbum
  module Api
    class Authorship < Base
      def self.resource
        "authorships"
      end

      def context
        @data["context"]
      end

      def year
        @data["year"]
      end

      def author
        Author.find(@data["links"]["author"])
      end

      def psalm
        Psalm.find(@data["links"]["psalm"])
      end
    end
  end
end
