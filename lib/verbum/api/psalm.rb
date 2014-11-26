module Verbum
  module Api
    class Psalm < Base
      attributes :title, :number
      associations :authors, :authorships, :tags, :theme, :verses
    end
  end
end
