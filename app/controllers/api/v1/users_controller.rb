class Api::V1::UsersController < Api::V1::BaseApiController
  before_action :authenticate_user_from_token!, only: [:opponents]

  def create
    user = User.new(user_params)
    if user.save
      render json: { status: 'User created successfully', access_token: user.access_token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def opponents
    opponents = User.where.not(id: @current_user.id).collect { |op| { id: op.id, name: op.name } }
    render json: { opponents: opponents }, status: :ok
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :password)
  end

end
