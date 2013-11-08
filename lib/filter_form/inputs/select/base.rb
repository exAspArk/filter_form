module FilterForm
  module Inputs
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
          object.klass.uniq.pluck(attribute_name)
        end
      end
    end
  end
end
