module Serializers
  class Base
    attr_reader :model

    def initialize(model)
      @model = model
    end

    def self.serialize_for(model_name)
      alias_method model_name, :model
    end
  end
end
