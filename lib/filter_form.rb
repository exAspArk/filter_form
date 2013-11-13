require 'filter_form/version'
require 'filter_form/form_helper'
require 'filter_form/simple_form/form_builder'
require 'filter_form/ransack/search'

module FilterForm
  class Engine < ::Rails::Engine
    require 'simple_form'
    require 'ransack'
    require 'jquery-rails'
    require 'select2-rails'
  end
end
