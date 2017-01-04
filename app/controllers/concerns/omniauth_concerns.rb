module OmniauthConcerns
  private def omniauth_email
    omniauth_env['info']['email']
  end

  private def omniauth_env
    request.env['omniauth.auth']
  end

  private def omniauth_name
    omniauth_env['info']['name']
  end

  private def omniauth_uid
    omniauth_env['uid']
  end
end
