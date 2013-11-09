module FilterForm
  module InputOptions
    module Select
      class Base < FilterForm::Inputs::Base
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
          options[:collection] || object.klass.uniq.pluck(attribute_name)
        end

        def input_class
          options[:in] == :select2 ? 'filter_form_select2' : super
        end
      end
    end
  end
end
