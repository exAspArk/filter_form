require 'rails'
require 'pry'
require 'action_view'
require 'active_model'

require 'support/active_record'

require 'filter_form'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.order = :random
end

I18n.backend.store_translations(:test, YAML::load_file('spec/fixtures/locale.yml'))
I18n.enforce_available_locales = false
I18n.default_locale = :test
