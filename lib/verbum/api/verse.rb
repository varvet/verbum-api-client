module Verbum
  module Api
    class Verse < Base
      attributes :body
      associations :psalm
    end
  end
end
