module FilterForm
  module Inputs
    module String
      class Date < FilterForm::Inputs::String::Base
        INPUT_CLASS = 'filter_form_date'
      end
    end
  end
end
