module FilterForm
  module InputOptions
    module Select
      class BelongsTo < FilterForm::Inputs::Select::Base
        private

        def object_condition
          object.base.conditions.select { |c| c.a.first.name == custom_attribute_name }.first
        end

        def collection
          options[:collection] || attribute_name.to_s.camelize.constantize.all
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
end
