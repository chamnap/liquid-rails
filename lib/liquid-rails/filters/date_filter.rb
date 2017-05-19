module Liquid
  module Rails
    module DateFilter
      delegate \
                :distance_of_time_in_words,
                :time_ago_in_words,

                to: :view_context

      private

        def view_context
          @view_context ||= @context.registers[:view]
        end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::DateFilter)