module Liquid
  module Rails
    module Rspec
      module ViewControllerContext
        extend ActiveSupport::Concern

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
          @context ||= ::Liquid::Context.new(assigns, {}, { helper: @view, view: @view, controller: @controller })
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