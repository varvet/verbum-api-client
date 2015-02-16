module Verbum
  module Api
    class Psalm < Base
      attributes :title, :number, :title_with_number, :addition, :note_sheet
      associations :authors, :authorships, :tags, :theme, :verses
    end
  end
end
