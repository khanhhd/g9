class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  api :GET, "/v1/users/", "show all users"
  def index
    @users = User.all
    json_response(@users)
  end

  api :POST, "/v1/users", "create user"
  param :name, String
  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  api :GET, "/v1/users/:id"
  param :id, String, desc: 'id of the requested user'
  def show
    json_response(@user)
  end

  api :PUT, '/v1/users/:id'
  param :name, String
  param :user_action, String, "actions: sleep, wakeup"
  def update
    result = UserService.new(params).take_action
    json_response(result, result[:status])
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private
  def user_params
    params.permit(:name)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
