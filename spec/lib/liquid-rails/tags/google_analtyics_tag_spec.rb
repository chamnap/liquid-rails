require 'spec_helper'

module Liquid
  module Rails
    describe GoogleAnalyticsTag, type: :tag do
      let(:context) { ::Liquid::Context.new({}, {}, { view: view }) }

      it '#google_analytics' do
        result = Liquid::Template.parse("{% google_analytics 'UA-XXXXX-X' %}").render(context)

        expect(result).to eq(
        %{
        <script type="text/javascript">

          var _gaq = _gaq || [];
          _gaq.push(['_setAccount', 'UA-XXXXX-X']);
          _gaq.push(['_trackPageview']);

          (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
          })();

        </script>
        }
        )
      end
    end
  end
end