class Api::V1::TrackingSleepsController < ApplicationController
  before_action :set_user
  before_action :set_tracking_sleep, only: [:show, :update, :destroy]

  def_param_group :tracking_sleep_filter do
    param :filter, String, "Filte tracking sleep for current user or friend e.g: 'me', 'friend'"
    param :user_id, String, "Current User ID"
    param :friend_id, String, "Friend "
  end

  api :GET, "/v1/users/:user_id/tracking_sleeps", "Get users sleep records"
  param_group :tracking_sleep_filter
  def index
    json_response(TrackingService.new(params).get_list)
  end

  private
  def tracking_sleep_params
    params.permit(:start_time, :end_time, :user_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_tracking_sleep
    @tracking_sleep = @user.tracking_sleeps.find_by!(id: params[:id]) if @user
  end
end
