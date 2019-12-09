class TrackingService
  VALID_FILTER = ["me", "friend"]

  def initialize params
    @current_user = User.find params[:id]
    @friend = User.find params[:friend_id]
    @filter = params[:filter]
  end

  def get_list
    case @filter
    when "friend"
      @friend.tracking_sleeps.order(period: :desc)
    else
      @current_user.tracking_sleeps.order(created_at: :desc)
    end
  end

  def valid_filter?
    params[:filter].in? VALID_FILTER
  end
end
