class Api::V1::UsersController < ApplicationController
  before_action :set_user_by_id, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @user, status: :ok
  end

  def update
    authenticate
    unless @current_user
      head :forbidden
      return
    end

    return unless @current_user.id == @user.id

    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private
  def set_user_by_id
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def authenticate
    return unless request.headers.key? 'Authorization'
    header = request.headers['Authorization']
    token = HashWithIndifferentAccess.new(JWT.decode(header, Rails.application.credentials.secret_key_base.to_s)[0])
    @current_user = User.find(token[:user_id])
  end
end
