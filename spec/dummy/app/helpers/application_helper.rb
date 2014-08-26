module ApplicationHelper
  def truncate_it(input, length)
    input[0..length] + '...'
  end
end