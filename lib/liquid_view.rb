require 'liquid_view/version'
require 'liquid_view/template_handler'
require 'liquid_view/file_system'
require 'liquid'

module LiquidView
  class Railtie < ::Rails::Railtie
    initializer 'liquid_view.register_template_handler' do |app|
      ActiveSupport.on_load(:action_view) do
        ActionView::Template.register_template_handler(:liquid, LiquidView::TemplateHandler)
      end
    end

    initializer 'liquid_view.include_partial' do |app|
      template_path = ::Rails.root.join('app/views')
      Liquid::Template.file_system = LiquidView::FileSystem.new(template_path)
    end
  end
end