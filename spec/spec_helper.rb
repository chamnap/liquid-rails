# frozen_string_literal: true

if ENV['CI'] || ENV['COVERAGE']
  require 'coveralls'
  require 'simplecov'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    add_filter 'drop_example_group.rb'
    add_filter 'tag_example_group.rb'
    add_filter 'spec'
    add_filter 'gemfiles'
  end
end

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require 'rails/version'
if ::Rails::VERSION::MAJOR == 6
  require File.expand_path('dummy6/config/environment.rb',  __dir__)
else
  require File.expand_path('dummy7/config/environment.rb',  __dir__)
end

require 'pry'
require 'pry-byebug'
require 'liquid-rails'
require 'rspec/rails'
require 'capybara/rspec'
require 'liquid-rails/matchers'

Liquid::Template.error_mode = :strict

Rails.backtrace_cleaner.remove_silencers!

# Load support files
require 'fixtures/poro'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.include Capybara::RSpecMatchers
  config.include ActiveSupport::Testing::SetupAndTeardown if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR < 2
  config.include ActionController::TestCase::Behavior
end
