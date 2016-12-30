module PresenterConcerns
  def presenter_for(model)
    klass = "Presenter::#{model.class.name}".constantize

    unless klass.respond_to?(:presenter?) && klass.presenter?
      raise NameError.new("uninitialized constant Presenter::#{model.class.name}")
    end

    presenter = klass.new(model, view_context)

    if block_given?
      yield presenter, i
    end

    presenter
  end
end
