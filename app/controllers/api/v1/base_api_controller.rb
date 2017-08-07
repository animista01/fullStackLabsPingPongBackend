class Api::V1::BaseApiController < ApplicationController
	protect_from_forgery with: :null_session

	before_action :destroy_session
	before_action :authenticate_user_from_token!

	private
	def authenticate_user_from_token!
		if request.headers['Authorization']
			if @current_user ||= User.find_by(access_token: request.headers['Authorization'])
			else
      	invalid_authenticate_attempt
			end
		else
      invalid_authenticate_attempt
		end
	end

	def destroy_session
		request.session_options[:skip] = true
	end

	def invalid_authenticate_attempt
    render json: { errors: "Error with your access token" }, status: 401
  end
end
