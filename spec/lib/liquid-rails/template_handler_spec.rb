require 'spec_helper'

describe 'Request', type: :feature do
  context 'render without layout' do
    it 'renders with liquid template' do
      visit '/'

      expect(page.body).to eq('Liquid on Rails')
    end

    it 'sets content_type as html by default' do
      visit '/'

      expect(page.response_headers['Content-Type']).to eq('text/html; charset=utf-8')
    end
  end

  context 'render with layout' do
    it 'renders with layout' do
      visit '/index_with_layout'

      expect(page.body).to eq("Application Layout\nLiquid on Rails")
    end
  end

  context 'render with partial' do
    it 'no full path for the current controller' do
      visit '/index_partial'

      expect(page.body).to eq("Application Layout\nLiquid on Rails\n\nHome Partial\nShared Partial")
    end

    it 'full path' do
      visit '/index_partial_with_full_path'

      expect(page.body).to eq("Application Layout\nLiquid on Rails\n\nHome Partial\nShared Partial")
    end

    it 'respects namespace of original template for partials path' do
      visit '/foospace/bar/index_partial'

      expect(page.body.strip).to eq("Foospace::BarController\n\nBar Partial")
    end
  end

  context 'render with filter' do
    it 'renders with helper' do
      visit '/index_with_filter'

      expect(page.body).to eq("Application Layout\nLiquid on Rails\nThis...")
    end

    it 'renders with helper' do
      visit '/index_without_filter'

      expect(page.body).to eq("Application Layout\nLiquid on Rails\nThis is a long section of text")
    end
  end

  context 'render html within an erb template' do
    it 'does not escape the html' do
      visit '/erb_with_html_liquid_partial'

      expect(page.body.strip).to eq("Application Layout\n<p>Partial Content</p>")
    end
  end
  
  context 'render RSS with an ERB template' do
    it 'returns an rss content type' do
      visit '/index_with_rss'

      expect(page.response_headers['Content-Type']).to eq('application/rss+xml; charset=utf-8')
    end
  end
end
