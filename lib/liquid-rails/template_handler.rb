module Liquid
  module Rails
    class TemplateHandler
      PROTECTED_ASSIGNS = %w( _routes template_root response _session template_class action_name request_origin session template
                              _response url _request _cookies variables_added _flash params _headers request cookies
                              ignore_missing_templates flash _params logger before_filter_chain_aborted headers )

      def self.call(template)
        "Liquid::Rails::TemplateHandler.new(self).render(#{template.source.inspect})"
      end

      def initialize(view)
        @view = view
      end

      def render(template)
        @view.controller.headers['Content-Type'] ||= 'text/html; charset=utf-8'

        assigns = @view.assigns.reject { |k, v| PROTECTED_ASSIGNS.include?(k) }
        assigns['content_for_layout'] = @view.content_for(:layout) if @view.content_for?(:layout)

        liquid = Liquid::Template.parse(template)
        liquid.render(assigns)
      end

      def compilable?
        false
      end
    end
  end
end