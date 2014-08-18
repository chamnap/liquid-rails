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

  it 'sets content_type as html by default' do
    visit '/'

    expect(page.response_headers['Content-Type']).to eq('text/html; charset=utf-8')
  end

  it 'renders partial liquid template' do
    visit '/'

    expect(page).to have_content "Application Layout\nLiquid on Rails\n\nPartial 1\nPartial 2"
  end
end