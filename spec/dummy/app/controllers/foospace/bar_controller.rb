class Foospace::BarController < ApplicationController
  def index_partial
    render layout: false
  end
end
