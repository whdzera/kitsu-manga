require "net/http"
require "uri"

class Users::RegistrationsController < Devise::RegistrationsController
  include Recaptcha::Adapters::ControllerMethods
  include Recaptcha::Adapters::ViewMethods

  def check_username
    user_exists = User.exists?(username: params[:username])
    render json: { taken: user_exists }
  end

  def create
    build_resource(sign_up_params)

    unless verify_recaptcha
      resource.errors.add(:base, "Verification reCAPTCHA failed. Try again.")
      clean_up_passwords(resource)
      set_minimum_password_length
      return render :new, status: :unprocessable_entity
    end

    resource.save
    yield resource if block_given?

    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice,
                           :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource,
                     location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      set_minimum_password_length
      render :new, status: :unprocessable_entity
    end
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    confirmation_instructions_path
  end
end
