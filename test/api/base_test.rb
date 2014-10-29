require "test_helper"

module Verbum
  module Api
    class Resource < Base
      attr_reader :data

      def self.resource
        "resources"
      end
    end

    class BaseTest < Minitest::Test
      def setup
        @resources = [{ "id" => 1 }, { "id" => 2 }, { "id" => 3 }]

        stub_request(:get, "http://localhost:3000/v1/resources").to_return(body: JSON.dump(
          "resources" => [@resources[0], @resources[1], @resources[2]]
        ))
        stub_request(:get, "http://localhost:3000/v1/resources/1").to_return(body: JSON.dump(
          "resources" => @resources[0]
        ))
        stub_request(:get, "http://localhost:3000/v1/resources/1,2").to_return(body: JSON.dump(
          "resources" => [@resources[0], @resources[1]]
        ))
      end

      def test_get_all_resources
        resources = Resource.all

        assert_instance_of Array, resources
        assert_equal 5, resources.length

        resources.each_with_index do |resource, i|
          assert_instance_of Resource, resource
          assert_equal @resources[i], resource.data
        end
      end

      def test_get_single_resource
        resource = Resource.find(1)

        assert_instance_of Resource, resource
        assert_equal @resources[0], resource.data
      end

      def test_get_multiple_resources_with_string
        resources = Resource.find("1,2")

        assert_instance_of Array, resources
        assert_equal 2, resources.length

        resources.each_with_index do |resource, i|
          assert_instance_of Resource, resource
          assert_equal @resources[i], resource.data
        end
      end

      def test_get_multiple_resources_with_array
        resources = Resource.find([1, 2])

        assert_instance_of Array, resources
        assert_equal 2, resources.length

        resources.each_with_index do |resource, i|
          assert_instance_of Resource, resource
          assert_equal @resources[i], resource.data
        end
      end
    end
  end
end
