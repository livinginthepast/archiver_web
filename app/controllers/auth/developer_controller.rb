class Auth::DeveloperController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :require_user

  before_action :fail_unless_dev

  def callback
    session[omniauth_session_key] = request.env['omniauth.auth']
    session[omniauth_session_key]['logged_in_at'] = Time.now.to_i
    redirect_to session['redirect_on_auth'] || root_path
  end

  def failure
    render plain: request.env['omniauth.auth'].to_hash.inspect
  end

  private

  def fail_unless_dev
    raise unless Rails.env.development?
  end
end

