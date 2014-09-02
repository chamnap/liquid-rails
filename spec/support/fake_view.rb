def view
  return @view if @view.present?

  @view                 = ActionView::Base.new
  @controller           = ApplicationController.new
  @request              = build_request
  @response             = build_response
  @response.request     = @request
  @controller.request   = @request
  @controller.response  = @response
  @controller.params    = {}
  @view.assign_controller(@controller)
  @view.class.send(:include, @controller._helpers)

  @view
end