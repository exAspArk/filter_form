module FilterForm
  module Inputs
    class DateEq < FilterForm::Inputs::String
      DATE_CLASS = 'filter_form_date'

    private

      def additional_input_options
        super.merge(class: DATE_CLASS)
      end
    end
  end
end
