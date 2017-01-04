module AuthenticationConcerns
  private def current_profile
    @current_user ||= Profile.where(id: session_profile_id).first
  end

  private def require_profile
    session['redirect_on_auth'] = request.path
    return true if current_profile.present?
    return redirect_to sign_in_path
  end

  private def session_profile_id
    session[profile_session_key]
  end

  private def session_profile_id=(id)
    session[profile_session_key] = id
    session['logged_in_at'] = Time.now.to_i
  end

  private def profile_session_key
    'profile.uuid'.freeze
  end
end
