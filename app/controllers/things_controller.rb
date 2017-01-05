class ThingsController < ApplicationController
  include PaginationConcerns

  def index
    @new = FormObjects::Thing.new(profile: current_profile)
    @things = Thing.where(profile: current_profile).order(:name).page(current_page)
  end

  def create
    @new = FormObjects::Thing.new(profile: current_profile, build_associations_after_validate: true)
    if @new.update(thing_params)
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def thing_params
    params.permit(
      thing: [
        :name,
        asset: [
          :content_type,
          :path,
        ]
      ]
    )
  end
end

