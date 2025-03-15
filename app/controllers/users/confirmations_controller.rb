class Users::ConfirmationsController < Devise::ConfirmationsController
  # Override method setelah user mengonfirmasi akun
  def show
    super do |resource|
      if resource.errors.empty? # Jika konfirmasi sukses
        sign_in(resource) # Langsung login user
        return redirect_to root_path, notice: "Your account has been confirmed successfully!"
      end
    end
  end
end
