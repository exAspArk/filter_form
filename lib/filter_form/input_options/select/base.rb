module FilterForm
  module InputOptions
    module Select
      class Base < FilterForm::InputOptions::Base
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
          options.delete(:in) == :select2 ? 'filter_form_select2' : super
        end
      end
    end
  end
end
