module Verbum
  module Api
    module Caching
      def with_caching(*args)
        return yield unless Verbum::Api.cache

        cache_key = ActiveSupport::Cache.expand_cache_key args, "verbum-api"
        options = {}
        options[:expires_in] = cache_expiry if Verbum::Api.cache_expires_in

        Verbum::Api.cache.fetch(cache_key, options) do
          yield
        end
      end

      def cache_expiry
        Verbum::Api.cache_expires_in.tap do |expiry|
          if Verbum::Api.cache_expiry_padding
            break Verbum::Api.cache_expires_in + rand(Verbum::Api.cache_expiry_padding)
          end
        end
      end
    end
  end
end
