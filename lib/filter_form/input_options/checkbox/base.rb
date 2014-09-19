module FilterForm
  module InputOptions
    module Checkbox
      class Base < FilterForm::InputOptions::Base
        include FilterForm::InputOptions::Shared::WithAssociations

        private

        def default_predicate
          PREDICATE_IN
        end

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
