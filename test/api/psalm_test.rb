require_relative "../test_helper"

class PsalmTest < Minitest::Test
  def test_the_truth
    VCR.use_cassette("psalm.all", record: :all) do
      x = Verbum::Api::Psalm.find(1)
      byebug
    end
  end
end
