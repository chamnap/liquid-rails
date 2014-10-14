require 'spec_helper'

module Liquid
  module Rails
    describe JavascriptTag, type: :tag do
      let(:context) { ::Liquid::Context.new({}, {}, { view: view }) }

      it '#crsf_meta_tags' do
        result = Liquid::Template.parse("{% javascript_tag %} alert('Hello Liquid-Rails!') {% endjavascript_tag %}").render(context)
        expect(result).to eq(%|<script type=\"text/javascript\">\n//<![CDATA[\n alert('Hello Liquid-Rails!') \n//]]>\n</script>|)
      end
    end
  end
end