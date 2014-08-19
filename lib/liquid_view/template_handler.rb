module LiquidView
  class TemplateHandler

    def self.call(template)
      "LiquidView::TemplateHandler.new(self).render(#{template.source.inspect}, local_assigns)"
    end

    def initialize(view)
      @view = view
    end

    def render(template, local_assigns={})
      @view.controller.headers['Content-Type'] ||= 'text/html; charset=utf-8'

      assigns = @view.assigns
      assigns['content_for_layout'] = @view.content_for(:layout) if @view.content_for?(:layout)
      assigns.merge!(local_assigns.stringify_keys)

      liquid = Liquid::Template.parse(template)
      liquid.render(assigns, registers: { view: @view })
    end

    def compilable?
      false
    end
  end
end