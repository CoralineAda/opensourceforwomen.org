require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'dotenv'

Bundler.require(*Rails.groups)
Bundler.require(:default, Rails.env)

I18n.enforce_available_locales = false

Dotenv::Railtie.load

module Opensourceforwomen
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.time_zone = 'Central Time (US & Canada)'
    config.generators.template_engine :haml
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.secret_key_base = "123098asdlkjlk123j19238098asdlkjaslkdasdkajlsdk1230912830912jlkasjdalksdjsa"
    config.assets.enabled = false
    config.assets.version = '1.0'
    config.active_record.raise_in_transactional_callbacks = true
  end
end
