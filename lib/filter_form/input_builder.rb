require 'filter_form/inputs/base'

require 'filter_form/inputs/select/base'
require 'filter_form/inputs/select/belongs_to'

require 'filter_form/inputs/string/base'
require 'filter_form/inputs/string/date'

module FilterForm
  class InputBuilder
    include ActiveModel::Model

    attr_accessor :attribute_name, :object, :custom_predicate, :custom_type

    def build
      input_class.new(attribute_name: attribute_name, object: object, predicate: predicate)
    end

  private

    def input_class
      result = "FilterForm::Inputs::#{ "#{ type }".camelize }".constantize
      raise NameError if result.class == Module
      result
    rescue NameError
      "FilterForm::Inputs::#{ "#{ type }/base".camelize }".constantize
    end

    def predicate
      return custom_predicate if custom_predicate

      case attribute_type
      when :string
        :cont
      else
        :eq
      end
    end

    def type
      return custom_type if custom_type

      case attribute_type
      when :string, :integer
        :string
      when :datetime, :date
        'string/date'
      when :belongs_to
        'select/belongs_to'
      end
    end

    def association_belongs_to?
      object.klass.reflections[attribute_name] && object.klass.reflections[attribute_name].belongs_to?
    end

    def attribute_type
      if association_belongs_to?
        :belongs_to
      else
        object.klass.columns_hash[attribute_name.to_s].type
      end
    end
  end
end
