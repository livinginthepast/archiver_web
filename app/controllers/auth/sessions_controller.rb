class Auth::SessionsController < ApplicationController
  skip_before_action :require_profile

  layout 'empty'

  def delete
    session.delete profile_session_key
    redirect_to root_path
  end

  def new

  end
end
