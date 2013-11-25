module FilterForm
  module InputOptions
    module Number
      class Base < FilterForm::InputOptions::Base
        private

        def additional_options
          { as: :integer }
        end

        def additional_input_options
          super.merge(value: input_value)
        end
      end
    end
  end
end
