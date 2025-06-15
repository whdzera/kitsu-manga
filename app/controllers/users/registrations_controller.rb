class Users::RegistrationsController < Devise::RegistrationsController
  def check_username
    user_exists = User.exists?(username: params[:username])
    render json: { taken: user_exists }
  end

  def verify_recaptcha(response_token, remote_ip = nil)
    uri = URI("https://www.google.com/recaptcha/api/siteverify")
    res =
      Net::HTTP.post_form(
        uri,
        {
          "secret" =>
            Rails.application.credentials.dig(:recaptcha, :secret_key),
          "response" => response_token,
          "remoteip" => remote_ip
        }
      )
    JSON.parse(res.body)["success"] == true
  end

  def create
    build_resource(sign_up_params)

    unless verify_recaptcha(params["g-recaptcha-response"], request.remote_ip)
      resource.errors.add(:base, "Verification reCAPTCHA failed. try again.")
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
