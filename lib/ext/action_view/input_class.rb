module ActionView
  class InputClass
    alias :to_html :to_s

    def initialize(classes)
      @classes = classes
    end

    def to_s
      @classes.join(' ')
    end

    def <<(klass)
      @classes << klass
      self
    end
  end

  def self.input_class(input)
    return InputClass.new([]) unless input['class']
    InputClass.new(input['class'].split(' '))
  end
end

