require 'liquid-rails/version'
require 'liquid'

module Liquid
  module Rails
    autoload :TemplateHandler, 'liquid-rails/template_handler'
    autoload :FileSystem,      'liquid-rails/file_system'

    # filters
    autoload :AssetUrlFilter,  'liquid-rails/filters/asset_url_filter'
  end
end

require 'liquid-rails/railtie' if defined?(Rails)