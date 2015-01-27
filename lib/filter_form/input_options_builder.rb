require 'filter_form/input_options/base'
require 'filter_form/input_options/shared/with_associations'
require 'filter_form/input_options/select/base'
require 'filter_form/input_options/string/base'
require 'filter_form/input_options/number/base'
require 'filter_form/input_options/number/money'
require 'filter_form/input_options/boolean/base'
require 'filter_form/input_options/checkbox/base'
require 'filter_form/input_options/radio_buttons/base'
require 'filter_form/input_options/date/base'
require 'filter_form/input_options/datetime/base'

module FilterForm
  class InputOptionsBuilder
    attr_accessor :object, :custom_predicate, :custom_type
    attr_reader :attribute_name

    def initialize(options)
      @object = options[:object]
      @custom_predicate = options[:custom_predicate]
      @custom_type = options[:custom_type]
      self.attribute_name = options[:attribute_name]
    end


    def build(options = {})
      input_options_class.new(attribute_name: attribute_name, object: object, custom_predicate: custom_predicate, options: options).simple_form_options
    end

    def attribute_name=(new_attribute_name)
      @attribute_name = new_attribute_name.to_s
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

    def type
      custom_type ? map_type(custom_type) : map_type(attribute_type)
    end

    def map_type(_type)
      case _type
      when :text
        'string/base'
      when :integer, :float, :decimal
        'number/base'
      when :money
        'number/money'
      when :select2
        'select/select2'
      when :boolean
        'boolean/base'
      when :check_boxes
        'checkbox/base'
      else
        _type
      end
    end

    def association?
      if ActiveRecord.try(:version).to_s.to_f >= 4.2
        !!object.klass.reflections[attribute_name]
      else
        !!object.klass.reflections[attribute_name.to_sym]
      end
    end

    def money?
      object.klass.columns_hash["#{ attribute_name }_cents"].present?
    end

    def attribute_type
      if association?
        :select
      elsif money?
        :money
      else
        object.klass.columns_hash[attribute_name].type
      end
    end
  end
end
