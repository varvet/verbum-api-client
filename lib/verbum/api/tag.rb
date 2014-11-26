module Verbum
  module Api
    class Tag < Base
      attributes :name
      associations :psalms
    end
  end
end
