class Api::V1::UsersController < ApplicationController
  before_action :format_email,  only: [:create]
  before_action :find_user,     only: [:show]
  before_action :validate_user, only: [:show]

  def create
    user = User.new(user_params)
    if user.save
      render json: { "success": "User added successfully" }, status: :created
    else
      render json: { "errors": user.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  def show
    if @user
      render json: UserSerializer.users([@user])
    else
      render json: { "errors": "Login is necessary" }, status: :not_found
    end
  end

  private
  def validate_user
    unless current_user
      render json: { "errors": "Unable to locate or authenticate user" }, status: :not_found
    end
  end

  def format_email
    params[:email]&.downcase!
  end

  def find_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation
    )
  end
end
