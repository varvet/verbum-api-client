require "test_helper"

module Verbum
  module Api
    class ThemeTest < Minitest::Test
      def setup
        @theme = Theme.new({
          "id" => 1,
          "title" => "Theme",
          "href" => "http://localhost:3000/v1/themes/1",
          "links" => {
            "psalms" => [1, 2, 3]
          }
        })
      end

      def test_title
        assert_equal "Theme", @theme.title
      end

      def test_psalms
        Psalm.expects(:find).with([1, 2, 3]) && @theme.psalms
      end
    end
  end
end
