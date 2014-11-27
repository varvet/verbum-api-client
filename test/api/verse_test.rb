require "test_helper"

module Verbum
  module Api
    class VerseTest < Minitest::Test
      def setup
        @verse = Verse.new({
          "id" => 1,
          "body" => "Lorem ipsum",
          "position" => 1,
          "href" => "http://localhost:3000/v1/verses/1",
          "links" => {
            "psalm" => 1
          }
        })
      end

      def test_body
        assert_equal "Lorem ipsum", @verse.body
      end

      def test_position
        assert_equal 1, @verse.position
      end

      def test_psalm
        Psalm.expects(:find).with(1) && @verse.psalm
      end
    end
  end
end
