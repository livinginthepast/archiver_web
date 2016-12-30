module AuthenticationConcerns
  private def current_user
    @current_user ||= User.from_google_auth(omniauth_session)
  end

  private def require_user
    session['redirect_on_auth'] = request.path
    return true if current_user.present?
    return redirect_to sign_in_path
  end

  private def omniauth_session
    session[omniauth_session_key]
  end

  private def omniauth_session_key
    'user.omniauth'.freeze
  end
end
