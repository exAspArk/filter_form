module FilterForm
  module InputOptions
    module Shared
      module WithAssociations
        def collection
          if options[:collection]
            options[:collection]
          elsif belongs_to?
            attribute_name.to_s.camelize.constantize.all
          elsif collection?
            attribute_name.to_s.camelize.singularize.constantize.all
          else
            object.klass.uniq.pluck(attribute_name)
          end
        end

        def association
          object.klass.reflections[attribute_name]
        end

        def belongs_to?
          association && association.belongs_to?
        end

        def collection?
          association && association.collection?
        end
      end
    end
  end
end
