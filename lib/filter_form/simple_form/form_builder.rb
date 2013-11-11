require 'filter_form/input_options_builder'

module SimpleForm
  class FormBuilder < ActionView::Helpers::FormBuilder
    def filter_input(attribute_name, options = {}, &block)
      input_options_builder = FilterForm::InputOptionsBuilder.new attribute_name:   attribute_name,
                                                                  object:           object,
                                                                  custom_type:      options.delete(:as),
                                                                  custom_predicate: options.delete(:predicate)

      input(attribute_name, input_options_builder.build(options), &block)
    end
  end
end
