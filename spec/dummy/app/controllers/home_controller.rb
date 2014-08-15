class HomeController < ApplicationController
  def index
    @book = { 'name' => 'Liquid on Rails' }
  end
end