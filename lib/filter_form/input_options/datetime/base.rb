module FilterForm
  module InputOptions
    module Datetime
      class Base < FilterForm::InputOptions::String::Base
        DEFAULT_PREDICATE = :eq

        private

        def additional_options
          { as: :datetime }
        end
      end
    end
  end
end
