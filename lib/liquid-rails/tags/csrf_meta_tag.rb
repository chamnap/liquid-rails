module Liquid
  module Rails
    class CsrfMetaTag < ::Liquid::Tag
      def render(context)
        context.registers[:view].csrf_meta_tags
      end
    end
  end
end

Liquid::Template.register_tag('csrf_meta_tags', Liquid::Rails::CsrfMetaTag)