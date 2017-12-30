module Liquid
  module Rails
    module Rspec
      module FilterExampleGroup
        extend ActiveSupport::Concern
        include Liquid::Rails::Rspec::ViewControllerContext

        included do
          metadata[:type] = :filter

          before(:each)  { setup_view_and_controller }
        end
      end
    end
  end
end

RSpec.configure do |config|
  if RSpec::Core::Version::STRING.starts_with?('3')
    config.include Liquid::Rails::Rspec::FilterExampleGroup, type: :filter, file_path: %r(spec/filters)
  else
    config.include Liquid::Rails::Rspec::FilterExampleGroup, type: :filter, example_group: { file_path: %r{spec/filters} }
  end
end
