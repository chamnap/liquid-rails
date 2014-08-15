require 'liquid-rails/version'
require 'liquid-rails/template_handler'
require 'liquid'

module Liquid
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'liquid-rails.register_template_handler' do |app|
        ActiveSupport.on_load(:action_view) do
          ActionView::Template.register_template_handler(:liquid, Liquid::Rails::TemplateHandler)
        end
      end
    end
  end
end