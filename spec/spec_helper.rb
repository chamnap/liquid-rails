if ENV['CI']
  require 'coveralls'
  require 'simplecov'
  SimpleCov.add_filter 'spec'
  Coveralls.wear!
end

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'pry'
require 'liquid-rails'
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end