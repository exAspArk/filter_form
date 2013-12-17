module FilterForm
  module InputOptions
    module Shared
      module WithAssociations
        def collection
          if options[:collection]
            options[:collection]
          elsif association
            association.klass.all
          else
            object.klass.uniq.pluck(attribute_name)
          end
        end
      end
    end
  end
end
