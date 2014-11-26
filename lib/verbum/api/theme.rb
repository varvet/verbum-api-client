module Verbum
  module Api
    class Theme < Base
      attributes :title
      associations :psalms
    end
  end
end
