def view
  return @view if @view.present?

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

  @view
end