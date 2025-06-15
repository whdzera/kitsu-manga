class Users::RegistrationsController < Devise::RegistrationsController
  def check_username
    user_exists = User.exists?(username: params[:username])
    render json: { taken: user_exists }
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    confirmation_instructions_path
  end
end
