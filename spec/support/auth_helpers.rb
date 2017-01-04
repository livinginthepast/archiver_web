module AuthHelpers
  def self.included(base)
    base.send(:extend, ContextHelpers)
  end

  module ContextHelpers
    def authenticate!
      let(:user) {
        FactoryGirl.create(:profile)
      }
      before do
        allow(controller).to receive(:current_profile).and_return(profile)
      end
    end
  end
end
