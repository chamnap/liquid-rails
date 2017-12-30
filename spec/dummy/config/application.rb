require_relative 'boot'

# Pick the frameworks you want:
require "rails/all"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)
require "liquid-rails"

module Dummy
  class Application < Rails::Application
    if Rails.version.start_with?('5.1')
      # Initialize configuration defaults for originally generated Rails version.
      config.load_defaults 5.1
    elsif Rails.version.start_with?('5.2')
      # Initialize configuration defaults for originally generated Rails version.
      config.load_defaults 5.2
      config.active_record.sqlite3.represent_boolean_as_integer = true
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
