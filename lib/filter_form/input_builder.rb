require 'filter_form/inputs/base'
require 'filter_form/inputs/string'

require 'filter_form/inputs/belongs_to_eq'
require 'filter_form/inputs/string_cont'
require 'filter_form/inputs/integer_eq'
require 'filter_form/inputs/date_eq'

module FilterForm
  class InputBuilder
    include ActiveModel::Model

    attr_accessor :attribute_name, :object

    def build
      "FilterForm::Inputs::#{ input_type.camelize }".constantize.new(attribute_name: attribute_name, object: object)
    end

  private

    def input_type
      "#{ type }_#{ predicate }"
    end

    def predicate
      case attribute_type
      when :string
        :cont
      else
        :eq
      end
    end

    def type
      case attribute_type
      when :string
        :string
      when :integer
        :integer
      when :datetime, :date
        :date
      when :belongs_to
        :belongs_to
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
