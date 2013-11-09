module FilterForm
  module InputOptions
    module String
      class Base < FilterForm::Inputs::Base
        private

        def additional_options
          { as: :string }
        end

        def additional_input_options
          super.merge(value: input_value)
        end
      end
    end
  end
end
