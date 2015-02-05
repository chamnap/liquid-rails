require 'spec_helper'

module Liquid
  module Rails
    describe CsrfMetaTags, type: :tag do
      let(:context) { ::Liquid::Context.new({}, {}, { view: view }) }

      it '#crsf_meta_tags' do
        allow(view).to receive(:protect_against_forgery?).and_return(true)
        allow(view).to receive(:form_authenticity_token).and_return('rails_form_authenticity_token')

        result = Liquid::Template.parse('{% csrf_meta_tags %}').render(context)
        metas  = result.split("\n").map { |item| Nokogiri::XML(item).children.first }
        expect(metas.length).to eq(2)
        expect(metas[0].name).to eq('meta')
        expect(metas[0]['name']).to eq('csrf-param')
        expect(metas[0]['content']).to eq('authenticity_token')

        expect(metas[1].name).to eq('meta')
        expect(metas[1]['name']).to eq('csrf-token')
        expect(metas[1]['content']).to eq('rails_form_authenticity_token')
      end
    end
  end
end