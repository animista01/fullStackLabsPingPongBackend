class Api::V1::SessionsController < Api::V1::BaseApiController
  skip_before_action :authenticate_user_from_token!, only: [:create]

  def create
    user = User.find_by(email: create_params[:email])
    password = create_params[:password]

    if user && user.valid_password?(password)
      sign_in user, store: false

      render json: user, status: 200
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  private
  def create_params
    params.require(:user).permit(:email, :password)
  end
end
