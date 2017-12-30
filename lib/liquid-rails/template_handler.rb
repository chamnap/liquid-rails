module Liquid
  module Rails
    class TemplateHandler

      def self.call(template)
        "Liquid::Rails::TemplateHandler.new(self).render(#{template.source.inspect}, local_assigns)"
      end

      def initialize(view)
        @view       = view
        @controller = @view.controller
        @helper     = ActionController::Base.helpers
      end

      def render(template, local_assigns={})
        assigns = if @controller.respond_to?(:liquid_assigns, true)
          @controller.send(:liquid_assigns)
        else
          @view.assigns
        end
        assigns['content_for_layout'] = @view.content_for(:layout) if @view.content_for?(:layout)
        assigns.merge!(local_assigns.stringify_keys)

        liquid      = Liquid::Template.parse(template)
        liquid.send(render_method, assigns, filters: filters, registers: registers).html_safe
      end

      def filters
        if @controller.respond_to?(:liquid_filters, true)
          @controller.send(:liquid_filters)
        else
          [@controller._helpers]
        end
      end

      def registers
        {
          view: @view,
          controller: @controller,
          helper: @helper,
          file_system: Liquid::Rails::FileSystem.new(@view)
        }
      end

      def compilable?
        false
      end

      def render_method
        (::Rails.env.development? || ::Rails.env.test?) ? :render! : :render
      end
    end
  end
end
