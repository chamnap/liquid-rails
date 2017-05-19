module Liquid
  module Rails
    module NumberFilter
      delegate \
                :number_to_phone,
                :number_to_currency,
                :number_to_percentage,
                :number_with_delimiter,
                :number_with_precision,
                :number_to_human_size,
                :number_to_human,

                to: :view_context

      private

        def view_context
          @view_context ||= @context.registers[:view]
        end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::NumberFilter)