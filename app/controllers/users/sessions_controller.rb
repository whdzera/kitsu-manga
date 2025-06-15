class Users::SessionsController < Devise::SessionsController
  def create
    unless verify_recaptcha(params["g-recaptcha-response"], request.remote_ip)
      flash.now[:alert] = "Verification reCAPTCHA failed. try again."
      self.resource = resource_class.new(sign_in_params)
      render :new, status: :unprocessable_entity and return
    end

    super
  end

  private

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
  rescue => e
    Rails.logger.error "reCAPTCHA error: #{e.message}"
    false
  end
end
