module Verbum
  module Api
    class Psalm < Base
      def self.resource
        "psalms"
      end

      def title
        @data["title"]
      end

      def number
        @data["number"]
      end

      def authors
        Author.find(@data["links"]["authors"])
      end

      def authorships
        Authorship.find(@data["links"]["authorships"])
      end

      def tags
        Tag.find(@data["links"]["tags"])
      end

      def theme
        Theme.find(@data["links"]["theme"])
      end

      def verses
        Verse.find(@data["links"]["verses"])
      end
    end
  end
end
