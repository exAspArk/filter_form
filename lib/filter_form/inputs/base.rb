module FilterForm
  module Inputs
    class Base
      include ActiveModel::Model

      INPUT_CLASS = ''

      attr_accessor :attribute_name, :object, :predicate

      def options
        result = default_options.merge(additional_options)
        result[:input_html].merge!(additional_input_options)
        result
      end

    private

      def default_options
        {
          required:   false,
          input_html: { name: input_name }
        }
      end

      def additional_options
        {}
      end

      def additional_input_options
        { class: self.class::INPUT_CLASS }
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
