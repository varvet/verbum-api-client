require_relative "../test_helper"

class VerseTest < Minitest::Test
  def setup
    @verse = Verbum::Api::Verse.new({
      "id" => 1,
      "body" => "Lorem ipsum",
      "href" => "http://localhost:3000/v1/verses/1",
      "links" => {
        "psalm" => 1
      }
    })
  end

  def test_id
    assert_equal 1, @verse.id
  end

  def test_body
    assert_equal "Lorem ipsum", @verse.body
  end

  def test_href
    assert_equal "http://localhost:3000/v1/verses/1", @verse.href
  end
end
