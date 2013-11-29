module FilterForm
  module InputOptions
    module Checkbox
      class Base < FilterForm::InputOptions::Base
        include FilterForm::InputOptions::Shared::WithAssociations

        DEFAULT_PREDICATE = :in

        private

        def additional_options
          {
            as: :check_boxes,
            collection: collection
          }
        end
      end
    end
  end
end
