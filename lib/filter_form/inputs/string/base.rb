module FilterForm
  module Inputs
    module String
      class Base < FilterForm::Inputs::Base
        def options
          result = super.merge(as: :string)
          result[:input_html].merge!(additional_input_options)
          result
        end

      private

        def additional_input_options
          {
            value: input_value
          }
        end
      end
    end
  end
end
