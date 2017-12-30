require 'spec_helper'

describe 'Request', type: :feature do
  describe 'layout' do
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
  end

  describe 'partial' do
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
  end

  describe 'filter' do
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
  end

  describe 'erb' do
    context 'render html within an erb template' do
      it 'does not escape the html' do
        visit '/erb_with_html_liquid_partial'

        expect(page.body.strip).to eq("Application Layout\n<p>Partial Content</p>")
      end
    end
  end

  describe 'content_type' do
    context 'render RSS with an ERB template' do
      it 'returns an rss content type' do
        visit '/index_with_rss.rss'

        expect(page.response_headers['Content-Type']).to eq('application/rss+xml; charset=utf-8')
      end
    end
  end

  describe 'custom actionview resolver' do
    before do
      ApplicationController.class_eval do
        before_action :prepend_view_path_if_param_present

        def prepend_view_path_if_param_present
          prepend_view_path Rails.root.join('vendor/theme') if params[:prepend_view_path]
        end
      end
    end

    it 'no full path for the current controller' do
      visit '/index_partial?prepend_view_path=true'

      expect(page.body).to eq("Application Layout\nLiquid on Rails\n\nVendor Theme Home Partial\n\nVendor Theme Shared Partial\n")
    end

    it 'full path' do
      visit '/index_partial_with_full_path?prepend_view_path=true'

      expect(page.body).to eq("Application Layout\nLiquid on Rails\n\nVendor Theme Home Partial\n\nVendor Theme Shared Partial\n")
    end

    it 'respects namespace of original template for partials path' do
      visit '/foospace/bar/index_partial?prepend_view_path=true'

      expect(page.body.strip).to eq("Foospace::BarController\n\nVendor Theme Bar Partial")
    end
  end
end
