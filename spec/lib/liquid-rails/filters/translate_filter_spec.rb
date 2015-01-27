require 'spec_helper'

module Liquid
  module Rails
    describe TranslateFilter do
      let(:context) { ::Liquid::Context.new }

      before do
        context.registers[:view] = ActionView::Base.new
      end

      it 'translate with default locale' do
        expect(::Liquid::Variable.new("'welcome' | translate").render(context)).to eq('Welcome everyone!')
      end

      it 'translate with specified locale' do
        expect(::Liquid::Variable.new("'welcome' | translate: 'km'").render(context)).to eq('សូមស្វាគមន៍')
      end

      it 'translate with scope' do
        expect(::Liquid::Variable.new("'home' | translate: 'km', 'links'").render(context)).to eq('ទំព័រដើម')
      end

      it 'translate with interpolation' do
        expect(::Liquid::Variable.new("'welcome_name' | translate: 'en', nil, name: 'Jeremy'").render(context)).to eq('Welcome, Jeremy')
      end
    end
  end
end
