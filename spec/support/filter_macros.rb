module FilterMacros

  def with_global_filter(*globals)
    original_filters = Array.new(Liquid::Strainer.class_variable_get(:@@filters))
    globals.each do |global|
      Liquid::Template.register_filter(global)
    end
    yield
  ensure
    Liquid::Strainer.class_variable_set(:@@filters, original_filters)
  end

end