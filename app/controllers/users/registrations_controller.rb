class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # Redirect user ke halaman cek email setelah registrasi
  def after_inactive_sign_up_path_for(resource)
    confirmation_instructions_path
  end
end