module Liquid
  module Rails
    module UrlFilter

      def link_to(name, url, options={})
        @context.registers[:helper].link_to(name, url.to_s, options)
      end

      def link_to_unless_current(name, url, options={})
        @context.registers[:helper].link_to_unless_current(name, url.to_s, options)
      end

      def mail_to(email_address, name=nil, options={})
        @context.registers[:helper].mail_to(email_address, name, options)
      end

      def current_page?(path)
        @context.registers[:view].current_page?(path.to_s)
      end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::UrlFilter)