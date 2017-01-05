class FormObjects::Thing
  include ActiveModel::Model

  attr_accessor :profile, :build_associations_after_validate
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

  validate :validate_children

  def thing
    @thing ||= ::Thing.new(profile: profile)
  end

  def asset
    @asset ||= begin
                 unless thing.persisted?
                   return thing.assets.first if thing.assets.any?
                   return thing.assets.build(thing: thing)
                 end
                 thing.assets.first
               end
  end

  def update(params)
    asset_params = params[:thing].delete(:asset)
    thing.assign_attributes(params[:thing])
    asset.assign_attributes(asset_params)
    binding.pry
    save
  end

  def save
    if valid?
      ActiveRecord::Base.transaction do
        thing.save
        asset.save
      end
      true
    else
      thing.assets.build(thing: thing) if build_associations_after_validate
      false
    end
  end

  private

  def validate_children
    if thing.invalid?
      denormalize_errors(thing.errors)
    end
    if asset.invalid?
      denormalize_errors(asset.errors)
    end
  end

  def denormalize_errors(child_errors)
    child_errors.each do |attr, msg|
      errors.add(attr, msg)
    end
  end
end
