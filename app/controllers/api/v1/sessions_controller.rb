class Api::V1::SessionsController < ApplicationController
  before_action :set_user_by_email, only: %i[create]

  def create
    unless @user
      render json: {}, status: :unauthorized
      return
    end

    unless @user.authenticate(login_params[:password])
      render json: {}, status: :unauthorized
      return
    end

    render json: {user: @user, token: JWT.encode({user_id: @user.id}, Rails.application.secrets.secret_key_base)}, status: :created
  end

  private
  def set_user_by_email
    @user = User.find_by(email: login_params[:email])
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
