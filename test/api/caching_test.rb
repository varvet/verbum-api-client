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

    class CachingTest < Minitest::Test
      def setup
        Verbum::Api.cache = ActiveSupport::Cache.lookup_store(:memory_store)
      end

      def teardown
        Verbum::Api.cache = nil
        Verbum::Api.cache_expires_in = nil
      end

      def test_get_all_resources_with_caching
        request = stub_request(:get, "https://api.verbumnovum.se/v1/resources")
          .to_return(
            body: { "resources" => [{ "id" => 1 }] }.to_json
          )

        Resource.all
        Resource.all

        assert_requested(request, times: 1)
      end

      def test_get_single_resource_with_caching
        request = stub_request(:get, "https://api.verbumnovum.se/v1/resources/1")
          .to_return(
            body: { "resources" => [{ "id" => 1 }] }.to_json
          )

        Resource.find(1)

        assert_requested(request, times: 1)
      end

      def test_caching_expiry
        expiry = Resource.send(:cache_expiry)

        assert_nil expiry

        Verbum::Api.cache_expires_in = 45.minutes
        expiry = Resource.send(:cache_expiry)

        assert_equal 45.minutes, expiry

        Verbum::Api.cache_expiry_padding = 15.minutes
        expiry = Resource.send(:cache_expiry)

        assert_operator expiry, :>=, 45.minutes
        assert_operator expiry, :<=, 1.hour
      end
    end
  end
end
