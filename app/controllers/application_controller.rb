class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:uid, :provider])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:uid, :provider, :last_name, :first_name, :profile])
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :last_name, :first_name, :profile])
    end
end
