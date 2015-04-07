module Verbum
  module Api
    module Attributes
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def attributes(*attributes)
          attributes.each do |attribute|
            define_method(attribute) do
              data[attribute.to_s]
            end
          end
        end

        def associations(*associations)
          associations.each do |association|
            define_method(association) do
              @_associations ||= {}
              @_associations[association] ||= begin
                if association_linked?(association.to_s)
                  load_association_from_linked(association.to_s)
                else
                  load_association_from_api(association.to_s)
                end
              end
            end
          end
        end
      end

      private

      def association_linked?(association)
        linked_association(association).present?
      end

      def linked_association(association)
        return unless linked.present?
        return unless links.present?
        linked[links["#{self.class.resource}.#{association}"]["type"]]
      end

      def linked_association_from_id(association, id)
        linked_association(association).find { |i| i["id"] == id }
      end

      def load_association_from_linked(association)
        association_class = "verbum/api/#{association.singularize}".classify.constantize

        if data["links"][association].is_a?(Array)
          data["links"][association].map do |link|
            association_class.from_data(
              linked_association_from_id(association, link)
            )
          end
        else
          association_class.from_data(
            linked_association_from_id(association, data["links"][association])
          )
        end
      end

      def load_association_from_api(association)
        reload! unless data["links"].present?

        "verbum/api/#{association.singularize}".classify.constantize.find(
          data["links"][association.to_s]
        )
      end
    end
  end
end
