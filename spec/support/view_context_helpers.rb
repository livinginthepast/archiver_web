module ViewContextHelpers
  def controller
    @controller ||= ApplicationController.new.tap do |c|
      c.request = ActionDispatch::TestRequest.create
    end
  end

  def view_context
    @view_context ||= controller.view_context
  end
end
