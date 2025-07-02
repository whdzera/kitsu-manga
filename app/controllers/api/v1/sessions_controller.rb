module Api
  module V1
    class SessionsController < Devise::SessionsController
      include ActionController::MimeResponds
      skip_before_action :verify_authenticity_token
      respond_to :json

      private

      def respond_with(resource, _opts = {})
        token = Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil)[0]

        render json: {
                 message: "Logged in successfully",
                 token: token,
                 user: resource
               },
               status: :ok
      end

      def respond_to_on_destroy
        render json: { message: "Logged out successfully" }, status: :ok
      end
    end
  end
end
