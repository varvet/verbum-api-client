require_relative "../test_helper"

class BaseTest < Minitest::Test
  # def test_psalm_all_returns_array_of_psalms
    # stub_request(:get, "http://localhost:3000/v1/psalms").to_return(
    #   body: JSON.dump({
    #     "links" => {
    #       "psalms.verses" => {
    #         "href" => "http://localhost:3000/v1/verses/{psalms.verses}",
    #         "type" => "verses"}
    #       },
    #     "psalms" => [{
    #       "id" => 1,
    #       "title" => "Psalm",
    #       "number" => "1",
    #       "href" => "http://localhost:3000/v1/psalms/1",
    #       "links" => {
    #         "verses" => [1, 2, 3]
    #       }
    #     }]
    #   }),
    #   status: 200
    # )
    #
    # psalms = Verbum::Api::Psalm.all
    #
    # assert_instance_of Array, psalms
    # assert_instance_of Verbum::Api::Psalm, psalms[0]
    # assert_equal "Psalm", psalms[0].title

    # TODO: perhaps we should simply test resource classes by injecting data
    # into their constructor, and make sure that works. then have separate
    # tests for the base class that makes sure the currect data gets injected
    # into constructors..?
  # end

end
