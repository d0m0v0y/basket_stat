module Api
  module V1
    class ApiController < ApplicationController
      #before_filter :authenticate_user_from_token!
      respond_to :json
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from Exception, with: :server_error

      resource_description do
        api_versions "1.0"
        api_base_url '/api/v1'
        formats [:json]
      end

      private

      def server_error(error)
        render json: { error: error.message }, status: :internal_server_error
      end

      def record_not_found
        render json: { error: '404 Not Found' }, status: :not_found
      end

      # def authenticate_user_from_token!
      #   user_email = params[:user_email].presence
      #   user = user_email && User.find_by_email(user_email)
      #
      #   # Notice how we use Devise.secure_compare to compare the token
      #   # in the database with the token given in the params, mitigating
      #   # timing attacks.
      #   if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      #     sign_in user, store: false
      #   end
      # end
    end
  end
end
