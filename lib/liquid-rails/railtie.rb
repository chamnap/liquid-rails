module Liquid
  module Rails
    class Railtie < ::Rails::Railtie
      config.app_generators.template_engine :liquid

      def self.setup
        yield self
      end

      mattr_accessor :template_file_system do
        Liquid::Rails::FileSystems::Local
      end

      initializer 'liquid-rails.register_template_handler' do |app|
        ActiveSupport.on_load(:action_view) do
          ActionView::Template.register_template_handler(:liquid, Liquid::Rails::TemplateHandler)
        end
      end

      initializer 'liquid-rails.include_partial' do |_|
        ::Rails.application.config.after_initialize do
          template_path = ::Rails.root.join('app/views')
          Liquid::Template.file_system = @@template_file_system.new(template_path)
        end
      end

      initializer 'liquid-rails.setup_drop' do |app|
        [:active_record, :mongoid].each do |orm|
          ActiveSupport.on_load orm do
            Liquid::Rails.setup_drop self
          end
        end
      end
    end
  end
end
