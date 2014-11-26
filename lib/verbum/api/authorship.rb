module Verbum
  module Api
    class Authorship < Base
      attributes :context, :year
      associations :author, :psalm
    end
  end
end
