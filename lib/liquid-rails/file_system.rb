# frozen_string_literal: true

require 'liquid/file_system'

module Liquid
  module Rails
    class FileSystem
      def initialize(view)
        @view = view
      end

      def read_template_file(template_path)
        controller_path = view.controller_path
        template_path   = "#{controller_path}/#{template_path}" unless template_path.include?('/')

        name    = template_path.split('/').last
        prefix  = template_path.split('/')[0...-1].join('/')

        result  = find_all_templates(name, prefix)
        raise FileSystemError, "No such template '#{template_path}'" if result.blank?

        result.first.source
      end

      private

      if ::Rails::VERSION::MAJOR < 7
        ActiveSupport::Deprecation.warn('liquid-rails is moving to Rails 7.0')
        def find_all_templates(name, prefix)
          view.view_paths.find_all(name, prefix, true, lookup_details)
        end
      else
        def find_all_templates(name, prefix)
          view.view_paths.find_all(name, prefix, true, lookup_details, nil, {})
        end
      end

      attr_reader :view

      def lookup_details
        {
          locale: [view.locale, :en],
          formats: view.formats,
          variants: [],
          handlers: [:liquid]
          # versions: []
        }
      end
    end
  end
end
