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
          label:      label,
          input_html: additional_input_options.merge(options.delete(:input_html) || {})
        }
      end

      def additional_options
        {}
      end

      def additional_input_options
        result = { name: input_name, data: {} }

        if input_class
          if options[:input_html]
            result[:class] = (options[:input_html].delete(:class) || '') << " #{ input_class }"
          else
            result[:class] = input_class
          end
        end

        result[:data][:predicate_selector] = options[:predicate_selector] if options[:predicate_selector]
        result[:data][:current_predicate]  = current_predicate            if current_predicate

        result
      end

      def label
        if options[:predicate_selector]
          attribute_name.to_s.titleize
        else
          "#{ attribute_name }_#{ Ransack::Translate.predicate(predicate) }".titleize
        end
      end

      def current_predicate
        if object_condition
          object_condition.predicate.name
        elsif options[:predicate_selector]
          predicate
        end
      end

      def input_class
        nil
      end

      def input_name
        "q[#{ input_attribute_name }_#{ predicate }]"
      end

      def input_value
        object_condition.values.first.value if object_condition
      end

      def object_condition
        if options[:predicate_selector]
          object.base.conditions.select { |condition| condition.a.first.name == input_attribute_name.to_s }.first
        else
          object.base.conditions.select do |condition|
            condition.a.first.name == input_attribute_name.to_s && condition.predicate.name == predicate.to_s
          end.first
        end
      end

      def input_attribute_name
        attribute_name
      end
    end
  end
end
