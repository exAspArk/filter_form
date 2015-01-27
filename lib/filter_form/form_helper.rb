module FilterForm
  module FormHelper
    def filter_form_for(record, options = {}, &block)
      options.reverse_merge!({
        url:    url_for,
        method: :get,
        html:   { class: 'filter_form', novalidate: true }
      })

      record.instance_eval do
        def model_name
          klass.model_name
        end
      end

      simple_form_for(record, options, &block)
    end
  end
end

ActionView::Base.send :include, FilterForm::FormHelper
