module FilterForm
  module InputOptions
    module Select
      class Base < FilterForm::InputOptions::Base
        DEFAULT_PREDICATE = :eq

        private

        def additional_options
          {
            as:            :select,
            collection:    collection,
            include_blank: true,
            selected:      input_value
          }
        end

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

        def input_attribute_name
          if association
            "#{ attribute_name }_id"
          else
            super
          end
        end

        def input_class
          if options[:in] == :select2
            'filter_form_select2'
          else
            super
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
