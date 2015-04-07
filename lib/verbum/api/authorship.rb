module Verbum
  module Api
    class Authorship < Base
      attributes :context, :year, :author_name
      associations :author, :psalm
    end
  end
end
