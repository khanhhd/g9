class Api::V1::TrackingSleepsController < ApplicationController
  before_action :set_user
  before_action :set_tracking_sleep, only: [:show, :update, :destroy]

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
