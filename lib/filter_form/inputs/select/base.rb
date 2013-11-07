module FilterForm
  module Inputs
    module Select
      class Base < FilterForm::Inputs::Base
        def options
          super.merge(additional_options)
        end

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
          []
        end
      end
    end
  end
end
