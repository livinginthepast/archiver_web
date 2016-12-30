class User
  include Virtus.model

  attribute :uid, Integer
  attribute :email, String
  attribute :name, String
  attribute :provider, String

  def self.from_google_auth(session)
    return unless session
    new(
      uid: session['uid'],
      email: session['info']['email'],
      name: session['info']['name'],
      provider: session['provider']
    )
  end
end
