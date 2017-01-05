class ThingsController < ApplicationController
  def index
    @new = FormObjects::Thing.new(with_new_records: true)
  end

  def create
    @new = FormObjects::Thing.new(build_associations_after_validate: true)
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
          :path,
        ]
      ]
    )
  end
end

