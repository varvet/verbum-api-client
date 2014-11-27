module Verbum
  module Api
    class Verse < Base
      attributes :body, :position
      associations :psalm
    end
  end
end
