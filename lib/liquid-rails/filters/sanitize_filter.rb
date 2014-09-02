module Liquid
  module Rails
    module SanitizeFilter
      delegate \
                :strip_tags,
                :strip_links,

                to: :h

      private

        def h
          @h ||= @context.registers[:helper]
        end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::SanitizeFilter)