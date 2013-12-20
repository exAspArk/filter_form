module FilterForm
  module InputOptions
    module String
      class Base < FilterForm::InputOptions::Base
        DEFAULT_PREDICATE = :cont

        private

        def additional_options
          { as: :string }
        end

        def additional_input_options
          if input_value
            super.merge(value: input_value)
          else
            super
          end
        end
      end
    end
  end
end
