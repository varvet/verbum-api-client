require "test_helper"

module Verbum
  module Api
    class TagTest < Minitest::Test
      def setup
        @tag = Tag.new({
          "id" => 1,
          "name" => "Tag",
          "href" => "http://localhost:3000/v1/tags/1",
          "links" => {
            "psalms" => [1, 2, 3]
          }
        })
      end

      def test_name
        assert_equal "Tag", @tag.name
      end

      def test_psalms
        Psalm.expects(:find).with([1, 2, 3]) && @tag.psalms
      end
    end
  end
end
