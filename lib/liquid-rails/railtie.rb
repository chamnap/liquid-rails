module Liquid
  module Rails
    class Railtie < ::Rails::Railtie
      config.app_generators.template_engine :liquid
      config.liquid_rails = ActiveSupport::OrderedOptions.new

      initializer 'liquid-rails.register_template_handler' do |app|
        ActiveSupport.on_load(:action_view) do
          ActionView::Template.register_template_handler(:liquid, Liquid::Rails::TemplateHandler)
        end
      end

      initializer 'liquid-rails.include_partial' do |app|
        template_path = ::Rails.root.join('app/views')
        Liquid::Template.file_system = Liquid::Rails::FileSystem.new(template_path)
      end

      initializer 'liquid-rails.setup_drop' do |app|
        [:active_record, :mongoid].each do |orm|
          ActiveSupport.on_load orm do
            Liquid::Rails.setup_drop self
          end
        end
      end

      config.after_initialize do
        Liquid::Rails.configure do |liquid_config|
          config.liquid_rails.each_pair do |key, value|
            liquid_config[key] = value
          end
        end
      end
    end
  end
end
