require 'spec_helper'

module Liquid
  module Rails
    describe GoogleAnalyticsTag, type: :tag do
      let(:context) { ::Liquid::Context.new({}, {}, { view: view }) }

      it '#google_analytics' do
        result = Liquid::Template.parse("{% google_analytics_tag 'UA-XXXXX-X' %}").render(context)

        expect(result).to eq(
        %{
        <script type="text/javascript">

          (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
          ga('create', 'UA-XXXXX-X', 'auto');
          ga('send', 'pageview');

        </script>
        }
        )
      end
    end
  end
end