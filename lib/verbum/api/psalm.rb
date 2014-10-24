module Verbum
  module Api
    class Psalm < Base
      class << self
        def all
          get "psalms"
        end

        def find(id)
          get "psalms/#{id}"
        end
      end
    end
  end
end
