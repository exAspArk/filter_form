module FilterForm
  module Inputs
    class BelongsToEq < FilterForm::Inputs::Base
      def options
        super.merge(additional_options)
      end

    private

      def additional_options
        {
          as:            :select,
          collection:    collection,
          include_blank: true,
          selected:      input_value
        }
      end

      def object_condition
        object.base.conditions.select { |c| c.a.first.name == custom_attribute_name }.first
      end

      def collection
        attribute_name.to_s.camelize.constantize.all
      end

      def input_name
        "q[#{ custom_attribute_name }_#{ predicate }]"
      end

      def custom_attribute_name
        "#{ attribute_name }_id"
      end
    end
  end
end
