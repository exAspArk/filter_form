module Ransack
  class Search
    def initialize(object, params = {}, options = {})
      (params ||= {}).delete_if { |k, v| v.blank? && v != false }
      convert_money_param_name_and_value!(object, params)
      @context = Context.for(object, options)
      @context.auth_object = options[:auth_object]
      @base = Nodes::Grouping.new(@context, 'and')
      build(params.with_indifferent_access)
    end

  private

    def convert_money_param_name_and_value!(object, params)
      money_attribute_name = object.column_names.select { |c| c.end_with?('_cents') }.first

      if money_attribute_name
        money_attribute_name = money_attribute_name.dup.gsub('_cents', '')
        money_param_name = params.keys.select { |c| c.start_with?(money_attribute_name) }.first.dup

        params[money_param_name.gsub(money_attribute_name, "#{ money_attribute_name }_cents")] = params.delete(money_param_name).to_f * 100
      end
    end
  end
end
