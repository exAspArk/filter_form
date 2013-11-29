module FilterForm
  module InputOptions
    module Select
      class Base < FilterForm::InputOptions::Base
        include FilterForm::InputOptions::Shared::WithAssociations

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
      end
    end
  end
end
