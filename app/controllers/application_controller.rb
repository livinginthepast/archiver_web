class ApplicationController < ActionController::Base
  include AuthenticationConcerns

  helper_method :current_profile

  protect_from_forgery with: :exception

  before_action :require_profile
end
