require 'liquid-rails/version'
require 'liquid-rails/template_handler'
require 'liquid-rails/file_system'
require 'liquid'

module Liquid
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'liquid-rails.register_template_handler' do |app|
        ActiveSupport.on_load(:action_view) do
          ActionView::Template.register_template_handler(:liquid, Liquid::Rails::TemplateHandler)
        end
      end

      initializer 'liquid-rails.include_partial' do |app|
        template_path = ::Rails.root.join('app/views')
        Liquid::Template.file_system = Liquid::Rails::FileSystem.new(template_path)
      end
    end
  end
end