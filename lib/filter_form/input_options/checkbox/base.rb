module FilterForm
  module InputOptions
    module Checkbox
      class Base < FilterForm::InputOptions::Base
        private

        def additional_options
          {
            as: :boolean
          }
        end
      end
    end
  end
end

