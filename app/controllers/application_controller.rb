class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
  
  private

  def render_not_found
    redirect_to "/404"
  end
  
end