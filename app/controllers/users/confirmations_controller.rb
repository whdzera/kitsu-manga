class Users::ConfirmationsController < Devise::ConfirmationsController
  
  def show
    super do |resource|
      if resource.errors.empty? 
        sign_in(resource) 
        return redirect_to root_path, notice: "Your account has been confirmed successfully!"
      end
    end
  end
  
end
