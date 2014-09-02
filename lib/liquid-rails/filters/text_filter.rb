module Liquid
  module Rails
    module TextFilter
      delegate \
                :truncate,
                :highlight,
                :excerpt,
                :pluralize,
                :word_wrap,
                :simple_format,

                to: :h

      private

        def h
          @h ||= @context.registers[:helper]
        end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::TextFilter)