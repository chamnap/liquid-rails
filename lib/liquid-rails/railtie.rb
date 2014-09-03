module Liquid
  module Rails
    class Railtie < ::Rails::Railtie
      config.app_generators.template_engine :liquid

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