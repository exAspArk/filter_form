module FilterForm
  module InputOptions
    module Number
      class Base < FilterForm::InputOptions::Base
        DEFAULT_PREDICATE = :eq

        private

        def additional_options
          { as: :integer }
        end

        def additional_input_options
          super.merge(value: input_value, step: 'any')
        end
      end
    end
  end
end
