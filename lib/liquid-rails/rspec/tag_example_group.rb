module Liquid
  module Rails
    module Rspec
      module TagExampleGroup
        extend ActiveSupport::Concern
        include Liquid::Rails::Rspec::ViewControllerContext

        included do
          metadata[:type] = :tag

          before(:all) { setup_view_and_controller }
        end

        def expect_template_result(template, expected, assigns={})
          # make assigns available inside context
          assigns.each do |key, value|
            context[key] = value
          end

          actual = Liquid::Template.parse(template).render!(context)
          expect(actual).to eq(expected)
        end
      end
    end
  end
end

RSpec.configure do |config|
  if RSpec::Core::Version::STRING.starts_with?('3')
    config.include Liquid::Rails::Rspec::TagExampleGroup, type: :tag, file_path: %r(spec/tags)
  else
    config.include Liquid::Rails::Rspec::TagExampleGroup, type: :tag, example_group: { file_path: %r{spec/tags} }
  end
end