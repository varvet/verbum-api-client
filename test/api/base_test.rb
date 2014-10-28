require_relative "../test_helper"

module Verbum
  module Api
    class Resource < Base
      def self.resource
        "resources"
      end
    end

    class BaseTest < Minitest::Test
      def setup
        stub_request(:get, "http://localhost:3000/v1/resources").to_return(body: JSON.dump(
          resources: [{ id: 1 }]
        ))
        stub_request(:get, "http://localhost:3000/v1/resources/1").to_return(body: JSON.dump(
          resources: { id: 1 }
        ))
        stub_request(:get, "http://localhost:3000/v1/resources/1,2,3").to_return(body: JSON.dump(
          resources: [{ id: 1 }, { id: 2 }, { id: 3 }]
        ))
      end

      def test_get_all_resources
        resources = Resource.all

        assert_instance_of Array, resources
        assert_instance_of Resource, resources[0]
      end

      def test_get_single_resource
        resource = Resource.find(1)

        assert_instance_of Resource, resource
      end

      def test_get_multiple_resources_with_string
        resources = Resource.find("1,2,3")

        assert_instance_of Array, resources
        assert_instance_of Resource, resources[0]
      end

      def test_get_multiple_resources_with_array
        resources = Resource.find([1, 2, 3])

        assert_instance_of Array, resources
        assert_instance_of Resource, resources[0]
      end
    end
  end
end
