# Class to be used as a Liquid File System for the `include` tag
# (so only for liquid partials)
module Liquid
  module Rails
    class ResolverSystem
      # Return a valid liquid template string for requested partial path
      def read_template_file(template_path, context)
        controller_path = context.registers[:controller].controller_path
        template_path   = "#{controller_path}/#{template_path}" unless template_path.include?('/')

        name = template_path.split('/').last
        prefix = template_path.split('/')[0...-1].join('/')
        locale = [context.registers[:controller].locale, :en]
        # something like {:locale=>[:pl, :en], :formats=>[:html], :variants=>[], :handlers=>[:erb, :builder, :raw, :ruby, :coffee, :jbuilder, :rabl, :liquid], :versions=>[:v10, :v9, :v8, :v7, :v6, :v5, :v4, :v3, :v2, :v1]}
        details = { locale: locale, formats: [:html], variants: [], handlers: [:liquid], versions:[] }
        result = context.registers[:controller].view_paths.find_all(name, prefix, partial=true, details)
        if result.present?
          result.first.source.force_encoding("UTF-8") # cast to utf8 as it was getting encoding errors
        else
          raise FileSystemError, "No such template '#{template_path}'"
        end
      end
    end
  end
end
