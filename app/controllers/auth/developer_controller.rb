class Auth::DeveloperController < ApplicationController
  include OmniauthConcerns

  skip_before_action :verify_authenticity_token
  skip_before_action :require_profile

  before_action :fail_unless_dev

  def callback
    omniauth = Omniauth.developer.where('lower(email) = :email',
                                        email: omniauth_email.downcase).first
    omniauth ||= Omniauth.developer.create!(
      profile: current_profile,
      uid: SecureRandom.uuid,
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

  private

  def fail_unless_dev
    raise unless Rails.env.development?
  end
end

