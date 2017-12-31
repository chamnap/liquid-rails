module Liquid
  module Rails
    module FileSystems
      autoload :Local,           'liquid-rails/file_systems/local'
      autoload :ApplicationWide, 'liquid-rails/file_systems/application_wide'
    end
  end
end
