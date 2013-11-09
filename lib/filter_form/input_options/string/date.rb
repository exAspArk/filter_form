module FilterForm
  module InputOptions
    module String
      class Date < FilterForm::InputOptions::String::Base
        private

        def input_class
          'filter_form_date'
        end
      end
    end
  end
end
