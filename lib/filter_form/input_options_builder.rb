require 'filter_form/input_options/base'

require 'filter_form/input_options/select/base'
require 'filter_form/input_options/select/belongs_to'
require 'filter_form/input_options/select/collection'

require 'filter_form/input_options/string/base'
require 'filter_form/input_options/string/date'
require 'filter_form/input_options/string/money'

require 'filter_form/input_options/checkbox/base'

module FilterForm
  class InputOptionsBuilder
    include ActiveModel::Model

    attr_accessor :attribute_name, :object, :custom_predicate, :custom_type

    def build(options)
      input_options_class.new(attribute_name: attribute_name, object: object, predicate: predicate, options: options).simple_form_options
    end

  private

    def input_options_class
      result = constantize_input_options_class("#{ type }".camelize)
      raise NameError if result.class == Module
      result
    rescue NameError
      constantize_input_options_class("#{ type }/base".camelize)
    end

    def constantize_input_options_class(class_name)
      "FilterForm::InputOptions::#{ class_name }".constantize
    end

    def predicate
      return custom_predicate if custom_predicate

      case type
      when :string
        :cont
      when :boolean
        :true
      else
        :eq
      end
    end

    def type
      custom_type ? map_type(custom_type) : map_type(attribute_type)
    end

    def map_type(_type)
      case _type
      when :integer, :text
        'string/base'
      when :datetime, :date
        'string/date'
      when :money
        'string/money'
      when :belongs_to
        'select/belongs_to'
      when :collection
        'select/collection'
      when :select2
        'select/select2'
      when :boolean
        'checkbox/base'
      else
        _type
      end
    end

    def belongs_to?
      object.klass.reflections[attribute_name] && object.klass.reflections[attribute_name].belongs_to?
    end

    def collection?
      object.klass.reflections[attribute_name] && object.klass.reflections[attribute_name].collection?
    end

    def money?
      object.klass.columns_hash["#{ attribute_name }_cents"].present?
    end

    def attribute_type
      if belongs_to?
        :belongs_to
      elsif collection?
        :collection
      elsif money?
        :money
      else
        object.klass.columns_hash[attribute_name.to_s].type
      end
    end
  end
end
