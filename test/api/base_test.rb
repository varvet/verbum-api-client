require "test_helper"

module Verbum
  module Api
    class Resource < Base
      attr_reader :data
      attributes :foo
      associations :bar, :baz
    end

    class Bar < Base; end
    class Baz < Base; end

    class BaseTest < Minitest::Test
      def setup
        @resources = [{ "id" => 1 }, { "id" => 2 }, { "id" => 3 }]

        stub_request(:get, "http://api.verbumnovum.se/v1/resources").to_return(body: JSON.dump(
          "resources" => [@resources[0], @resources[1], @resources[2]]
        ))
        stub_request(:get, "http://api.verbumnovum.se/v1/resources/1").to_return(body: JSON.dump(
          "resources" => @resources[0]
        ))
        stub_request(:get, "http://api.verbumnovum.se/v1/resources/1,2").to_return(body: JSON.dump(
          "resources" => [@resources[0], @resources[1]]
        ))
      end

      def test_get_all_resources
        resources = Resource.all

        assert_instance_of Array, resources
        assert_equal 3, resources.length

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

      def test_empty_resource_id
        resource = Resource.find("")

        assert resource.nil?
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

      def test_id
        resource = Resource.new({
          "id" => 1
        })
        assert_equal 1, resource.id
      end

      def test_href
        resource = Resource.new({
          "href" => "http://api.verbumnovum.se/v1/resources/1"
        })
        assert_equal "http://api.verbumnovum.se/v1/resources/1", resource.href
      end

      def test_attribute
        resource = Resource.new({
          "id" => 1,
          "foo" => "bar"
        })
        assert_equal "bar", resource.foo
      end

      def test_has_one_association
        stub_request(:get, "http://api.verbumnovum.se/v1/bars/1").to_return(body: JSON.dump(
          "bars" => { "id" => 1 }
        ))

        resource = Resource.new({
          "id" => 1,
          "links" => {
            "bar" => 1
          }
        })
        assert resource.bar.present?
      end

      def test_blank_has_one_association
        resource = Resource.new({
          "id" => 1,
          "links" => {
            "bar" => nil
          }
        })
        assert_equal nil, resource.bar
      end

      def test_has_many_association
        stub_request(:get, "http://api.verbumnovum.se/v1/bazs/1,2").to_return(body: JSON.dump(
          "bazs" => [{ "id" => 1 }, { "id" => 2 }]
        ))

        resource = Resource.new({
          "id" => 1,
          "links" => {
            "baz" => [1, 2]
          }
        })
        assert resource.baz.present?
      end

      def test_blank_has_many_association
        resource = Resource.new({
          "id" => 1,
          "links" => {
            "baz" => []
          }
        })
        assert_equal [], resource.baz
      end
    end
  end
end
