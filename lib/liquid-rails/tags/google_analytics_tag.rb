# Returns a Google Analytics tag.
#
# Usage:
#
# {% google_analytics_tag 'UA-XXXXX-X' %}

module Liquid
  module Rails
    class GoogleAnalyticsTag < ::Liquid::Tag
      Syntax = /(#{::Liquid::QuotedFragment}+)?/

      def initialize(tag_name, markup, tokens)
        if markup =~ Syntax
          @account_id = $1.gsub('\'', '')
        else
          raise ::Liquid::SyntaxError.new("Syntax Error in 'google_analytics_tag' - Valid syntax: google_analytics_tag <account_id>")
        end

        super
      end

      def render(context)
        %{
        <script type="text/javascript">

          (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
          ga('create', '#{@account_id}', 'auto');
          ga('send', 'pageview');

        </script>
        }
      end
    end
  end
end

Liquid::Template.register_tag('google_analytics_tag', Liquid::Rails::GoogleAnalyticsTag)