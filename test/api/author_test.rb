require "test_helper"

module Verbum
  module Api
    class AuthorTest < Minitest::Test
      def setup
        @author = Author.new({
          "id" => 1,
          "name" => "Author",
          "href" => "http://localhost:3000/v1/authors/1",
          "links" => {
            "authorships" => [1, 2, 3]
          }
        })
      end

      def test_name
        assert_equal "Author", @author.name
      end

      def test_authorships
        Authorship.expects(:find).with([1, 2, 3]) && @author.authorships
      end
    end
  end
end
