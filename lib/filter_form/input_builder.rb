require 'filter_form/inputs/base'

require 'filter_form/inputs/select/base'
require 'filter_form/inputs/select/belongs_to_eq'

require 'filter_form/inputs/string/base'
require 'filter_form/inputs/string/string_cont'
require 'filter_form/inputs/string/integer_eq'
require 'filter_form/inputs/string/date_eq'

module FilterForm
  class InputBuilder
    include ActiveModel::Model

    attr_accessor :attribute_name, :object, :options

    def build
      "FilterForm::Inputs::#{ input_type.camelize }".constantize.new attribute_name: attribute_name,
                                                                     object:         object,
                                                                     predicate:      options[:predicate]
    end

  private

    def input_type
      if options[:as]
        "#{ options[:as] }/base"
      else
        "#{ type }_#{ predicate }"
      end
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
        'string/string'
      when :integer
        'string/integer'
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
