require 'ext/action_view/error_renderer'

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  ActionView::ErrorWrapper.new(html_tag, instance).to_html
end
