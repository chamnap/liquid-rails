require 'liquid/file_system'

module Liquid
  module Rails
    module FileSystems
      class ApplicationWide < ::Liquid::LocalFileSystem
        def read_template_file(template_path, context)
          controller_path = context.registers[:controller].controller_path
          view_paths      = context.registers[:controller].view_paths

          unless template_path.starts_with?('/')
            template_path   = "#{controller_path}/#{template_path}" unless template_path.include?('/')
          end

          template_name   = template_path.split('/')[-1]
          template_path   = template_path.split('/')[0..-2].join('/')

          full_path       = ""
          template_found  = false

          view_paths.each do |path|
            full_path = find_file(path, template_path, template_name)

            if File.exist?(full_path)
              template_found = true
              break
            end
          end

          template_name = File.join(template_path, template_name)
          raise FileSystemError, "No such template '#{template_name}'" unless template_found

          File.read(full_path)
        end

        def find_file(path, template_path, template_name)
          full_path = File.join(path, template_path, @pattern % template_name)

          full_path
        end
      end
    end
  end
end
