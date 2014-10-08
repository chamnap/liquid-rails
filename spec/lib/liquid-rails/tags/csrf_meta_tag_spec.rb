require 'spec_helper'

module Liquid
  module Rails
    describe CsrfMetaTag, type: :tag do
      let(:context) { ::Liquid::Context.new({}, {}, { view: view }) }

      it '#crsf_meta_tags' do
        view.stub(:protect_against_forgery?).and_return(true)

        result = Liquid::Template.parse('{% csrf_meta_tags %}').render(context)
        expect(result).to eq(%|<meta content=\"authenticity_token\" name=\"csrf-param\" />\n<meta content=\"#{view.form_authenticity_token}\" name=\"csrf-token\" />|)
      end
    end
  end
end