module Liquid
  module Rails
    module TextFilter
      delegate \
                :highlight,
                :excerpt,
                :pluralize,
                :word_wrap,
                :simple_format,

                to: :__h__

      # right justify and padd a string
      def rjust(input, integer, padstr = '')
        input.to_s.rjust(integer, padstr)
      end

      # left justify and padd a string
      def ljust(input, integer, padstr = '')
        input.to_s.ljust(integer, padstr)
      end

      def underscore(input)
        input.to_s.gsub(' ', '_').gsub('/', '_').underscore
      end

      def dasherize(input)
        input.to_s.gsub(' ', '-').gsub('/', '-').dasherize
      end

      def concat(input, *args)
        result = input.to_s
        args.flatten.each { |a| result << a.to_s }
        result
      end

      private

        def __h__
          @context.registers[:view]
        end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::TextFilter)
