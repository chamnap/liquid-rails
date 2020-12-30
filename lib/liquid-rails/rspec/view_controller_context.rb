module Liquid
  module Rails
    module Rspec
      module ViewControllerContext
        extend ActiveSupport::Concern

        def setup_view_and_controller
          @controller           = ActionController::Base.new
          @view                 = ActionView::Base.new(ActionView::LookupContext.new(''), {}, @controller)
          @request              = ActionDispatch::TestRequest.new({'PATH_INFO' => '/'})
          @response             = ActionDispatch::TestResponse.new
          @response.request     = @request
          @controller.request   = @request
          @controller.response  = @response
          @controller.params    = {}
          @view.assign_controller(@controller)
          @view.class.send(:include, @controller._helpers)
          @view.class.send(:include, ::Rails.application.routes.url_helpers)
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
          expect(actual.to_s.strip).to eq(expected.to_s.strip)
        end
      end
    end
  end
end
