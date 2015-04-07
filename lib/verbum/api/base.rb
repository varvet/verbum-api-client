module Verbum
  module Api
    class Base
      include Verbum::Api::Attributes
      include Verbum::Api::Querying

      class << self
        def resource
          name.demodulize.tableize
        end

        def from_data(data, links = nil, linked = nil)
          resource_name = name.demodulize.underscore.to_sym

          if Verbum::Api.wrappers.key?(resource_name)
            Verbum::Api.wrappers[resource_name].new(new(data, links, linked))
          else
            new(data, links, linked)
          end
        end
      end

      attr_reader :data, :links, :linked

      def initialize(data, links = nil, linked = nil)
        @data = data
        @links = links
        @linked = linked
      end

      def id
        data["id"]
      end

      def href
        data["href"]
      end

      def count_links(association)
        return unless data["links"]
        return unless data["links"].key?(association.to_s)
        Array(data["links"][association.to_s]).length
      end

      def as_json(_options = nil)
        data
      end

      def reload!
        object = self.class.find(id)
        @data = object.data
        @links = object.links
        @linked = object.linked
      end
    end
  end
end
