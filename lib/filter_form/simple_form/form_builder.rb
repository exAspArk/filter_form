require 'filter_form/input_builder'

module SimpleForm
  class FormBuilder < ActionView::Helpers::FormBuilder
    def filter_input(attribute_name, options = {}, &block)
      input_builder = FilterForm::InputBuilder.new attribute_name:   attribute_name,
                                                   object:           object,
                                                   custom_type:      options[:as],
                                                   custom_predicate: options[:predicate]

      options.reverse_merge!(input_builder.build.options)

      input(attribute_name, options, &block)
    end
  end
end
