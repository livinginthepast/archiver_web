class FormObjects::Thing
  include ActiveModel::Model

  attr_accessor :with_new_records, :build_associations_after_validate
  attr_writer :thing

  delegate :id,
    :name,
    to: :thing

  delegate :model_name,
    :persisted?,
    :to_key,
    :to_param,
    :to_partial_path,
    to: :thing

  def thing
    @thing || ::Thing.new
  end

  def asset
    return thing.assets.build(thing: thing) if with_new_records
    thing.assets.first
  end

  def update(params)

  end
end
