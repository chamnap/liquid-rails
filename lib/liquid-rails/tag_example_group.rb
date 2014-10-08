module Liquid
  module Rails
    module TagExampleGroup
      extend ActiveSupport::Concern

      included do
        metadata[:type] = :tag

        before(:all) { setup_view_and_controller }
      end

      def setup_view_and_controller
        @view                 = ActionView::Base.new
        @controller           = ApplicationController.new
        @request              = ActionController::TestRequest.new
        @response             = ActionController::TestResponse.new
        @response.request     = @request
        @controller.request   = @request
        @controller.response  = @response
        @controller.params    = {}
        @view.assign_controller(@controller)
        @view.class.send(:include, @controller._helpers)
      end

      def view
        @view
      end

      def controller
        @controller
      end

      def context(assigns={})
        ::Liquid::Context.new(assigns, {}, { helper: @view, view: @view, controller: @controller })
      end

      def expect_template_result(template, expected, assigns={})
        actual = Liquid::Template.parse(template).render!(assigns, { registers: { helper: @view, view: @view, controller: @controller } })
        expect(actual).to eq(expected)
      end

      RSpec.configure do |config|
        if RSpec::Core::Version::STRING.starts_with?('3')
          config.include Liquid::Rails::TagExampleGroup, type: :tag, file_path: %r(spec/tags)
        else
          config.include Liquid::Rails::TagExampleGroup, type: :tag, example_group: { file_path: %r{spec/tags} }
        end
      end
    end
  end
end