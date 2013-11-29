module FilterForm
  module MoneyConverter
    extend ActiveSupport::Concern

    included do
      before_filter :convert_money_param_name_and_value, only: :index
    end

    private

    def convert_money_param_name_and_value
      money_column_name = resource_class.column_names.select { |c| c.end_with?('_cents') }.first

      if money_column_name && params[:q]
        money_attribute_name = money_column_name.dup.gsub('_cents', '')
        money_param_name = params[:q].keys.select { |c| c.start_with?(money_attribute_name) }.first

        if money_param_name
          params[:q][money_param_name.gsub(money_attribute_name, "#{ money_attribute_name }_cents")] = params[:q].delete(money_param_name).to_f * 100
        end
      end
    end

    def resource_class
      self.class.name.split('::').last.gsub('Controller', '').singularize.constantize
    end
  end
end
