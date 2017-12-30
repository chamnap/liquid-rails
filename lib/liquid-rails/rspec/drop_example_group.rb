module Liquid
  module Rails
    module Rspec
      module DropExampleGroup
        extend ActiveSupport::Concern
        include Liquid::Rails::Rspec::DropMatchers
        include Liquid::Rails::Rspec::ViewControllerContext

        included do
          metadata[:type] = :drop

          subject {
            if described_class.ancestors.include?(Liquid::Rails::Drop)
              begin
                described_class.new(double)
              rescue
                described_class.new
              end
            else
              described_class.new([])
            end
          }

          before(:each) { setup_view_and_controller }
          before(:each) { subject.context = context }
        end
      end
    end
  end
end

RSpec.configure do |config|
  if RSpec::Core::Version::STRING.starts_with?('3')
    config.include Liquid::Rails::Rspec::DropExampleGroup, type: :drop, file_path: %r(spec/drops)
  else
    config.include Liquid::Rails::Rspec::DropExampleGroup, type: :drop, example_group: { file_path: %r{spec/drops} }
  end
end
