module Liquid
  module Rails
    module DateFilter
      delegate \
                :distance_of_time_in_words,
                :time_ago_in_words,

                to: :h

      def h
        @h ||= @context.registers[:view]
      end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::DateFilter)