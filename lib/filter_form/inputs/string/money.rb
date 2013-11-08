module FilterForm
  module Inputs
    module String
      class Money < FilterForm::Inputs::String::Base
        private

        def input_value
          if object_condition
            object_condition.values.first.value.to_f / 100
          end
        end

        def object_condition
          object.base.conditions.select { |c| c.a.first.name == "#{ attribute_name }_cents" }.first
        end
      end
    end
  end
end
