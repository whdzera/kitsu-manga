module Api
  module V1
    class SessionsController < Devise::SessionsController
      skip_before_action :verify_authenticity_token
      respond_to :json

      private

      def respond_with(resource, _opts = {})
        render json: {
                 message: "Logged in successfully",
                 token: request.env["warden-jwt_auth.token"],
                 user: resource
               },
               status: :ok
      end

      def respond_to_on_destroy
        jwt_payload =
          JWT.decode(
            request.headers["Authorization"].split(" ").last,
            Rails.application.credentials.devise_jwt_secret_key,
            true,
            algorithm: "HS256"
          )[
            0
          ]

        current_user = User.find(jwt_payload["sub"])

        if current_user
          render json: { message: "Logged out successfully" }, status: :ok
        else
          render json: { message: "Invalid token" }, status: :unauthorized
        end
      rescue StandardError
        render json: { message: "Invalid token" }, status: :unauthorized
      end
    end
  end
end
