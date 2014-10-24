require "minitest/autorun"
require "verbum/api"

class ApiTest < Minitest::Test
  def test_foo
    assert_equal Verbum::Api::Client.new.foo, "bar"
  end
end
