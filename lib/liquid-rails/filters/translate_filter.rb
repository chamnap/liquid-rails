module Liquid
  module Rails
    module TranslateFilter
      def translate(key, locale = nil, scope = nil, options = Hash.new)
        locale ||= ::I18n.locale.to_s
        options.merge!({locale: locale, scope: scope})

        @context.registers[:view].translate(key.to_s, options.with_indifferent_access)
      end
    end
  end
end

Liquid::Template.register_filter Liquid::Rails::TranslateFilter
