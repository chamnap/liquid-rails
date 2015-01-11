module Liquid
  module Rails
    module TranslateFilter
      def translate(key, locale = nil, scope = nil)
        locale ||= ::I18n.locale.to_s

        @context.registers[:view].translate(key.to_s, locale: locale, scope: scope)
      end

      def t(name, vars={})
        @context.registers[:view].translate(name).gsub(/\{\{(.*?)\}\}/) {
          "#{vars[$1.strip]}"
        }
      end
    end
  end
end

Liquid::Template.register_filter Liquid::Rails::TranslateFilter