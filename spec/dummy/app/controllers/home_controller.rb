class HomeController < ApplicationController
  before_filter :set_book

  def index
    render layout: false
  end

  def index_with_layout
  end

  def index_partial
  end

  def index_partial_with_full_path
  end

  def index_with_filter
  end

  def erb_with_html_liquid_partial
  end

  def index_with_rss
    render format: 'rss', layout: false, content_type: 'application/rss+xml'
  end

  private

    def set_book
      @book = { 'name' => 'Liquid on Rails' }
    end
end
