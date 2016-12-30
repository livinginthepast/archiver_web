class ApplicationController < ActionController::Base
  include AuthenticationConcerns

  protect_from_forgery with: :exception

  before_action :require_user
end
