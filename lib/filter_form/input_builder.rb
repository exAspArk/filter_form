require 'filter_form/inputs/base'

require 'filter_form/inputs/select/base'
require 'filter_form/inputs/select/belongs_to'

require 'filter_form/inputs/string/base'
require 'filter_form/inputs/string/date'
require 'filter_form/inputs/string/money'

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
      custom_type ? map_type(custom_type) : map_type(attribute_type)
    end

    def map_type(_type)
      case _type
      when :integer
        'string/base'
      when :datetime, :date
        'string/date'
      when :money
        'string/money'
      when :belongs_to
        'select/belongs_to'
      else
        _type
      end
    end

    def association_belongs_to?
      object.klass.reflections[attribute_name] && object.klass.reflections[attribute_name].belongs_to?
    end

    def money?
      object.klass.columns_hash["#{ attribute_name }_cents"].present?
    end

    def attribute_type
      if association_belongs_to?
        :belongs_to
      elsif money?
        :money
      else
        object.klass.columns_hash[attribute_name.to_s].type
      end
    end
  end
end
