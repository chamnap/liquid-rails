module Liquid
  module Rails
    module DropExampleGroup
      extend ActiveSupport::Concern

      included do
        metadata[:type] = :drop

        subject { described_class }
      end

      RSpec.configure do |config|
        if RSpec::Core::Version::STRING.starts_with?('3')
          config.include DropExampleGroup, type: :drop, file_path: %r(spec/drops)
        else
          config.include DropExampleGroup, type: :drop, example_group: { file_path: %r{spec/drops} }
        end
      end
    end
  end
end