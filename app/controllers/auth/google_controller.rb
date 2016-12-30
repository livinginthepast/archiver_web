class Auth::GoogleController < ApplicationController
  skip_before_action :require_user

  def callback
    session[omniauth_session_key] = request.env['omniauth.auth']
    session[omniauth_session_key]['logged_in_at'] = Time.now.to_i
    redirect_to session['redirect_on_auth'] || root_path
  end

  def failure
    render plain: request.env['omniauth.auth'].to_hash.inspect
  end
end
