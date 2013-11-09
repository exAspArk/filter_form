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
          input_html: { name: input_name }.merge(additional_input_options).merge(options.delete(:input_html) || {})
        }
      end

      def additional_options
        {}
      end

      def additional_input_options
        input_class ? { class: input_class } : {}
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
