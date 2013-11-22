module FilterForm
  module InputOptions
    module Select
      class BelongsTo < FilterForm::InputOptions::Select::Base
        private

        def collection
          options[:collection] || attribute_name.to_s.camelize.constantize.all
        end

        def input_attribute_name
          "#{ attribute_name }_id"
        end
      end
    end
  end
end
