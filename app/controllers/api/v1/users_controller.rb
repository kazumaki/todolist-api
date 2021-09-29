class Api::V1::UsersController < ApplicationController
  before_action :set_user_by_id, only: [:show, :destroy]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save then
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @user, status: :ok
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
    params.permit(:email)
  end
end
