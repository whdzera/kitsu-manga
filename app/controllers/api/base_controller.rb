class Api::BaseController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  before_action :authenticate_user!

  private

  def require_admin
    unless current_user&.admin?
      render json: {
               error: "You are not authorized to perform this action."
             },
             status: :forbidden
    end
  end
end
