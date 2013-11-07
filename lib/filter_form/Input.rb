module FilterForm
  class Input
    DATE_CLASS = 'filter_form_date'

    include ActiveModel::Model

    attr_accessor :attribute_name, :object

    def options
      result = default_options

      case type
      when :select
        result.merge!(select_options)
      else
        result[:input_html].merge!(value: input_value)
      end

      case attribute_type
      when :datetime, :date
        result[:input_html].merge!(class: DATE_CLASS)
      end

      result
    end

  private

    def default_options
      {
        as:         type,
        required:   false,
        input_html: { name: input_name }
      }
    end

    # Select options ------------------------------------------------------------

    def select_options
      {
        collection:    collection,
        include_blank: true,
        selected:      selected
      }
    end

    def collection
      if reference_attribute?
        attribute_name.to_s.gsub('_id', '').camelize.constantize.all
      else
        object.klass.pluck(attribute_name).uniq
      end
    end

    def selected
      if object_condition.present?
        input_value
      else
        false
      end
    end

    # ---------------------------------------------------------------------------

    def input_name
      "q[#{ input_attribute_name }]"
    end

    def type
      return :select if reference_attribute?

      case attribute_type
      when :string, :integer, :datetime, :date
        :string
      when :float
        :float
      when :boolean
        :radio_buttons
      else
        :select
      end
    end

    def input_value
      object_condition.values.first.value if object_condition
    end

    def reference_attribute?
      attribute_name.to_s.end_with?('_id')
    end

    def object_condition
      object.base.conditions.select { |c| c.a.first.name == attribute_name.to_s }.first
    end

    def input_attribute_name
      "#{ attribute_name }_#{ predicate_name }"
    end

    def attribute_type
      object.klass.columns_hash[attribute_name.to_s].type
    end

    def predicate_name
      case attribute_type
      when :string
        'cont'
      else
        'eq'
      end
    end
  end
end
