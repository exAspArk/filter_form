module FilterForm
  module InputOptions
    class Base
      DEFAULT_PREDICATE = nil
      PREDICATE_IN = :in

      attr_accessor :attribute_name, :object, :custom_predicate, :options

      def initialize(options)
        @attribute_name = options[:attribute_name]
        @object = options[:object]
        @custom_predicate = options[:custom_predicate]
        @options = options[:options]
      end

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
        result = { name: input_name }

        if input_class
          if options[:input_html]
            result[:class] = (options[:input_html].delete(:class) || '') << " #{ input_class }"
          else
            result[:class] = input_class
          end
        end

        if options[:predicate_selector]
          result.deep_merge!(data: { predicate_selector: options[:predicate_selector] })
        end

        if current_predicate
          result.deep_merge!(data: { current_predicate: current_predicate })
        end

        result
      end

      def label
        if options[:predicate_selector]
          human_attribute_name
        else
          "#{ human_attribute_name } #{ Ransack::Translate.predicate(predicate) }"
        end
      end

      def human_attribute_name
        if association
          association.klass.model_name.human
        else
          object.klass.human_attribute_name(attribute_name)
        end
      end

      def association
        if ActiveRecord.try(:version).to_s.to_f >= 4.2
          object.klass.reflections[attribute_name]
        else
          object.klass.reflections[attribute_name.to_sym]
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

      def multiple?
        options[:input_html].try(:[], :multiple)
      end

      def input_name
        result = "q[#{ input_attribute_name }_#{ predicate }]"
        result << "[]" if multiple?
        result
      end

      def input_value
        object_condition.values.first.value if object_condition
      end

      def object_condition
        if options[:predicate_selector]
          object.base.conditions.select { |condition| condition.a.first.name == input_attribute_name }.first
        else
          object.base.conditions.select do |condition|
            condition.a.first.name == input_attribute_name && condition.predicate.name == predicate.to_s
          end.first
        end
      end

      def input_attribute_name
        attribute_name
      end

      def default_predicate
        multiple? ? PREDICATE_IN : self.class::DEFAULT_PREDICATE
      end

      def predicate
        custom_predicate || default_predicate
      end
    end
  end
end
