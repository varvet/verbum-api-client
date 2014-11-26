require "test_helper"

module Verbum
  module Api
    class AuthorshipTest < Minitest::Test
      def setup
        @authorship = Authorship.new({
          "id" => 1,
          "context" => "lyrics",
          "year" => "1990",
          "href" => "http://localhost:3000/v1/authorships/1",
          "links" => {
            "author" => 1,
            "psalm" => 1
          }
        })
      end

      def test_context
        assert_equal "lyrics", @authorship.context
      end

      def test_year
        assert_equal "1990", @authorship.year
      end

      def test_author
        Author.expects(:find).with(1) && @authorship.author
      end

      def test_psalm
        Psalm.expects(:find).with(1) && @authorship.psalm
      end
    end
  end
end
