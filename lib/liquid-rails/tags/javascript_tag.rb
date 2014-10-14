# Returns a JavaScript tag with the content inside.
#
# Usage:
#
# {% javascript_tag %}
#   alert('Hello Liquid Rails!');
# {% endjavascript_tag %}

module Liquid
  module Rails
    class JavascriptTag < ::Liquid::Block
      include ActionView::Helpers::JavaScriptHelper
      include ActionView::Helpers::TagHelper

      def render(context)
        javascript_tag(super, type: 'text/javascript')
      end
    end
  end
end

Liquid::Template.register_tag('javascript_tag', Liquid::Rails::JavascriptTag)