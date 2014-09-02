module Liquid
  module Rails
    module TranslateFilter
      def translate(key, locale = nil, scope = nil)
        locale ||= ::I18n.locale.to_s

        @context.registers[:helper].translate(key.to_s, locale: locale, scope: scope)
      end
    end
  end
end

Liquid::Template.register_filter Liquid::Rails::TranslateFilter