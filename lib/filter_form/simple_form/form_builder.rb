require 'filter_form/input'

module SimpleForm
  class FormBuilder < ActionView::Helpers::FormBuilder
    def filter_input(attribute_name, options = {}, &block)
      filter_input = FilterForm::Input.new(attribute_name: attribute_name, object: object)
      options.reverse_merge!(filter_input.options)

      input(attribute_name, options, &block)
    end
  end
end
