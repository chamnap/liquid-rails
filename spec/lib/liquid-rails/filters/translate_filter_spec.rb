require 'spec_helper'

module Liquid
  module Rails
    describe TranslateFilter do
      let(:context) { ::Liquid::Context.new }

      before do
        context.registers[:helper] = ActionController::Base.helpers
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
    end
  end
end