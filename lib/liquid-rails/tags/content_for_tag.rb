# It works similar to Rails #content_for.
# Calling #content_for stores a block of markup in an identifier for later use.
# In order to access this stored content in other templates or the layout, you would pass the identifier as an argument to content_for.
#
# Usage:
#
# {% content_for not_authorized %}
#   alert('You are not authorized to do that!');
# {% endcontent_for %}
#
# You can then use content_for :not_authorized anywhere in your templates.
# {% if current_user.nil? %}
#   {% yield not_authorized %}
# {% endif %}

module Liquid
  module Rails
    class ContentForTag < ::Liquid::Block
      Syntax = /(#{::Liquid::QuotedFragment}+)\s*(flush\s*(true|false))?/

      def initialize(tag_name, markup, context)
        super

        if markup =~ Syntax
          @flush = $3
          @identifier = $1.gsub('\'', '')
        else
          raise SyntaxError.new("Syntax Error - Valid syntax: {% content_for [name] %}")
        end
      end

      def render(context)
        @context = context
        content  = super.html_safe

        if ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MINOR == 2
          if @flush == 'true'
            @context.registers[:view].view_flow.set(@identifier, content) if content
          else
            @context.registers[:view].view_flow.append(@identifier, content) if content
          end
        else
          options = @flush == 'true' ? { flush: true } : {}
          @context.registers[:view].content_for(@identifier, content, options)
        end
        ''
      end
    end
  end
end

module Liquid
  module Rails
    class YieldTag < ::Liquid::Tag
      Syntax = /(#{::Liquid::QuotedFragment}+)/

      def initialize(tag_name, markup, context)
        super

        if markup =~ Syntax
          @identifier = $1.gsub('\'', '')
        else
          raise SyntaxError.new("Syntax Error - Valid syntax: {% yield [name] %}")
        end
      end

      def render(context)
        @context = context

        @context.registers[:view].content_for(@identifier).try(:html_safe)
      end
    end
  end
end

Liquid::Template.register_tag('content_for', Liquid::Rails::ContentForTag)
Liquid::Template.register_tag('yield', Liquid::Rails::YieldTag)