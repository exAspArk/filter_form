module FilterForm
  module InputOptions
    module RadioButtons
      class Base < FilterForm::InputOptions::Base
        include FilterForm::InputOptions::Shared::WithAssociations

        DEFAULT_PREDICATE = :eq

        private

        def additional_options
          {
            as: :radio_buttons,
            collection: collection,
            checked: input_value
          }
        end
      end
    end
  end
end
