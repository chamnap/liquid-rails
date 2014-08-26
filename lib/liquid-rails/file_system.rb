require 'liquid/file_system'

module Liquid
  module Rails
    class FileSystem < ::Liquid::LocalFileSystem
      def read_template_file(template_path, context)
        controller_name = context.registers[:view].controller.controller_name
        template_path   = "#{controller_name}/#{template_path}" unless template_path.include?('/')

        super
      end
    end
  end
end