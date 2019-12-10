class TrackingService
  VALID_FILTER = ["me", "friend"]

  def initialize params
    @current_user = User.find_by id: params[:user_id]
    @friend = User.find_by id: params[:friend_id]
    @filter = params[:filter]
  end

  def get_list
    case @filter
    when "friend"
      friend_activities
    when "me"
      my_activities
    else
      []
    end
  end

  def my_activities
    return [] unless @current_user
    @current_user.tracking_sleeps.order(created_at: :desc)
  end

  def friend_activities
    if @current_user && @friend && @current_user.following?(@friend)
      @friend.tracking_sleeps.from_last_week.order(period: :desc)
    else
      []
    end
  end

  def valid_filter?
    @filter.in? VALID_FILTER
  end
end
