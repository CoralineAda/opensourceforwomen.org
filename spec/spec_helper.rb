ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'database_cleaner'
require 'pry'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.include Sorcery::TestHelpers::Rails::Controller, type: :controller
  config.include Sorcery::TestHelpers::Rails::Integration, type: :feature

end

module Sorcery
  module TestHelpers
    module Rails
      module Integration
        def login_user_post(email, password)
          page.driver.post(sessions_url, { email: email, password: password})
        end
      end
    end
  end
end

def sign_in_user
  User.create!(
    username: 'Coraline',
    email: 'coraline@idolhands.com',
    salt: 'asdasdasd21391231',
    password: 'foo123456',
    crypted_password: Sorcery::CryptoProviders::BCrypt.encrypt("foo123456", "asdasdasd21391231"),
  )
  User.last.activate!
  login_user_post("coraline@idolhands.com", "foo123456")
end
