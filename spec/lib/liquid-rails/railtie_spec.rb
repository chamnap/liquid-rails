require 'spec_helper'

describe Liquid::Rails::Railtie do
  context 'template_engine :liquid' do
    it 'sets template_engine to :liquid' do
      expect(Rails.configuration.app_generators.rails[:template_engine]).to eq(:liquid)
    end
  end
end