module Verbum
  module Api
    class Psalm < Base
      attributes :title, :number, :title_with_number, :addition, :note_sheet, :soundcloud_stream_url, :soundcloud_length
      associations :authors, :authorships, :tags, :theme, :verses

      def composers
        @composers ||= authorships.group_by(&:context)["melody"] || []
      end

      def lyricists
        @lyricists ||= authorships.group_by(&:context)["lyrics"] || []
      end
    end
  end
end
