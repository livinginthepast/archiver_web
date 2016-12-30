module AuthHelpers
  def self.included(base)
    base.send(:extend, ContextHelpers)
  end

  module ContextHelpers
    def authenticate!
      let(:user) {
        User.new(
          uid: SecureRandom.uuid,
          email: Faker::Internet.email,
          name: Faker::Name.name,
          provider: 'google',
        )
      }
      before do
        allow(controller).to receive(:current_user).and_return(user)
      end
    end
  end
end
