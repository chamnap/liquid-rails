module Liquid
  module Rails
    module TranslateFilter
      def translate(key, options={})
        # Convert everything to symbols
        options = options.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
        options = { locale: ::I18n.locale.to_s }.merge(options)

        @context.registers[:view].translate(key.to_s, options)
      end
      alias_method :t, :translate
    end
  end
end

Liquid::Template.register_filter Liquid::Rails::TranslateFilter