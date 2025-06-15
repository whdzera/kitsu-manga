require "net/http"
require "uri"
class Users::SessionsController < Devise::SessionsController
  include Recaptcha::Adapters::ControllerMethods
  include Recaptcha::Adapters::ViewMethods
  def create
    unless verify_recaptcha
      flash.now[:alert] = "Verification reCAPTCHA failed. Try again."
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      render :new, status: :unprocessable_entity
      return
    end

    super
  end
end
