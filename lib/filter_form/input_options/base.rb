module FilterForm
  module InputOptions
    class Base
      include ActiveModel::Model

      attr_accessor :attribute_name, :object, :predicate, :options

      def simple_form_options
        default_options.merge(additional_options).merge(options)
      end

    private

      def default_options
        {
          required:   false,
          input_html: additional_input_options.merge(options.delete(:input_html) || {})
        }
      end

      def additional_options
        {}
      end

      def additional_input_options
        result = { name: input_name, data: {} }

        result[:class]                    = input_class       if input_class
        result[:data][:with]              = options[:with]    if options[:with]
        result[:data][:current_predicate] = current_predicate if current_predicate

        result
      end

      def current_predicate
        object.base.conditions.first.predicate.name if object.base.conditions.any?
      end

      def input_class
        nil
      end

      def input_name
        "q[#{ attribute_name }_#{ predicate }]"
      end

      def input_value
        object_condition.values.first.value if object_condition
      end

      def object_condition
        object.base.conditions.select { |c| c.a.first.name == attribute_name.to_s }.first
      end
    end
  end
end
