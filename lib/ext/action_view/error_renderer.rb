require 'ext/action_view/input_class'

module ActionView
  class ErrorWrapper
    attr_reader :html_tag, :instance

    def initialize(html_tag, instance)
      @html_tag = html_tag
      @instance = instance
    end

    def taggable?
      html_tag =~ /(input|textarea|select)/
    end

    def to_html
      return html_tag unless taggable?

      fragment = Nokogiri::HTML::DocumentFragment.parse(html_tag)
      input = fragment.at_css('input,textarea,select'.freeze)
      input['class'] = ActionView.input_class(input) << 'error'
      fragment.to_html.html_safe
    end
  end
end
