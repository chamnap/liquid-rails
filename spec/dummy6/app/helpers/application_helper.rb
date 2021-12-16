# frozen_string_literal: true

module ApplicationHelper
  def truncate_it(input, length)
    "#{input[0..length]}..."
  end
end
