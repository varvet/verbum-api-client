require "test_helper"

module Verbum
  module Api
    class PsalmTest < Minitest::Test
      def setup
        @psalm = Psalm.new({
          "id" => 1,
          "title" => "Psalm",
          "number" => "1",
          "href" => "http://localhost:3000/v1/psalms/1",
          "links" => {
            "authors" => [1, 2, 3],
            "authorships" => [1, 2, 3],
            "tags" => [1, 2, 3],
            "theme" => 1,
            "verses" => [1, 2, 3]
          }
        })
      end

      def test_title
        assert_equal "Psalm", @psalm.title
      end

      def test_number
        assert_equal "1", @psalm.number
      end

      def test_authors
        Author.expects(:find).with([1, 2, 3]) && @psalm.authors
      end

      def test_authorships
        Authorship.expects(:find).with([1, 2, 3]) && @psalm.authorships
      end

      def test_tags
        Tag.expects(:find).with([1, 2, 3]) && @psalm.tags
      end

      def test_theme
        Theme.expects(:find).with(1) && @psalm.theme
      end

      def test_verses
        Verse.expects(:find).with([1, 2, 3]) && @psalm.verses
      end
    end
  end
end
