module Verbum
  module Api
    class Author < Base
      attributes :name
      associations :authorships
    end
  end
end
