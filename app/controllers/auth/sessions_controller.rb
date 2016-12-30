class Auth::SessionsController < ApplicationController
  skip_before_action :require_user

  layout 'empty'

  def delete
    session.delete omniauth_session_key
    redirect_to root_path
  end

  def new

  end
end
