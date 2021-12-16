# frozen_string_literal: true

module Foospace
  class BarController < ApplicationController
    def index_partial
      render layout: false
    end
  end
end
