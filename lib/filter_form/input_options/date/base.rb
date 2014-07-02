module FilterForm
  module InputOptions
    module Date
      class Base < FilterForm::InputOptions::String::Base
        DEFAULT_PREDICATE = :eq

        private

        def additional_options
          { as: :date }
        end
      end
    end
  end
end
