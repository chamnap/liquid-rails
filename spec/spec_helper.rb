if ENV['CI'] || ENV['COVERAGE']
  require 'coveralls'
  require 'simplecov'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    add_filter 'drop_example_group.rb'
    add_filter 'spec'
    add_filter 'gemfiles'
  end
end

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'pry'
require 'liquid-rails'
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

Liquid::Template.error_mode = :strict

Rails.backtrace_cleaner.remove_silencers!

# Load support files
require 'fixtures/poro'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.include Capybara::RSpecMatchers
  config.include ActiveSupport::Testing::SetupAndTeardown
  config.include ActionController::TestCase::Behavior
end