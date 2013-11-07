require 'filter_form/input_builder'

module SimpleForm
  class FormBuilder < ActionView::Helpers::FormBuilder
    def filter_input(attribute_name, options = {}, &block)
      filter_form_input = FilterForm::InputBuilder.new(attribute_name: attribute_name, options: options, object: object).build

      options.reverse_merge!(filter_form_input.options)

      input(attribute_name, options, &block)
    end
  end
end
