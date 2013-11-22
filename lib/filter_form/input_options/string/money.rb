module FilterForm
  module InputOptions
    module String
      class Money < FilterForm::InputOptions::String::Base
        private

        def input_value
          if object_condition
            object_condition.values.first.value.to_f / 100
          end
        end

        def input_attribute_name
          "#{ attribute_name }_cents"
        end
      end
    end
  end
end
