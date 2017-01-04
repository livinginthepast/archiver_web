class Auth::GoogleController < ApplicationController
  include OmniauthConcerns

  skip_before_action :require_profile

  def callback
    omniauth = Omniauth.google.where('lower(email) = :email',
                                        email: omniauth_email.downcase).first
    omniauth ||= Omniauth.google.create!(
      profile: current_profile,
      uid: omniauth_uid,
      email: omniauth_email,
      name: omniauth_name,
      provider: 'developer',
    )

    self.session_profile_id = omniauth.profile_id

    redirect_to session['redirect_on_auth'] || root_path
  end

  def failure
    render plain: request.env['omniauth.auth'].to_hash.inspect
  end
end
