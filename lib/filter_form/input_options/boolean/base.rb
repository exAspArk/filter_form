module FilterForm
  module InputOptions
    module Boolean
      class Base < FilterForm::InputOptions::Base
        DEFAULT_PREDICATE = :true

        private

        def additional_options
          { as: :boolean }
        end

        def additional_input_options
          super.merge(checked: !!input_value)
        end
      end
    end
  end
end

