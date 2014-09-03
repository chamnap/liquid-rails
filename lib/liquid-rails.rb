require 'liquid-rails/version'
require 'liquid'

module Liquid
  module Rails
    autoload :TemplateHandler, 'liquid-rails/template_handler'
    autoload :FileSystem,      'liquid-rails/file_system'
  end
end

require 'liquid-rails/railtie' if defined?(Rails)
Dir[File.dirname(__FILE__) + '/liquid-rails/{filters,tags}/*.rb'].each { |f| require f }