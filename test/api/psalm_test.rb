require_relative "../test_helper"

class PsalmTest < Minitest::Test
  def setup
    @psalm = Verbum::Api::Psalm.new({
      "id" => 1,
      "title" => "Psalm",
      "number" => "1",
      "href" => "http://localhost:3000/v1/psalms/1",
      "links" => {
        "verses" => [1, 2, 3]
      }
    })
  end

  def test_id
    assert_equal 1, @psalm.id
  end

  def test_title
    assert_equal "Psalm", @psalm.title
  end

  def test_number
    assert_equal "1", @psalm.number
  end

  def test_href
    assert_equal "http://localhost:3000/v1/psalms/1", @psalm.href
  end
end
