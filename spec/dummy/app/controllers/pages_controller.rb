class PagesController < ApplicationController
  before_action :set_book

  def index_witout_filter
  end

  private

    def liquid_filters
      []
    end

    def set_book
      @book = { 'name' => 'Liquid on Rails' }
    end
end
