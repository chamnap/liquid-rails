require 'spec_helper'

describe 'Request', type: :feature do
  it 'renders with liquid template' do
    visit '/'

    expect(page).to have_content 'Liquid on Rails'
  end

  it 'renders with layout' do
    visit '/'

    expect(page).to have_content "Application Layout\nLiquid on Rails"
  end

  it 'set content_type as html by default' do
    visit '/'

    expect(page.response_headers['Content-Type']).to eq('text/html; charset=utf-8')
  end
end