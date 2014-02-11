require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

require 'dotenv'

Bundler.require(:default, Rails.env)

I18n.enforce_available_locales = false

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
  end
end
