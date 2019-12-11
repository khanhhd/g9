class RelationshipService
  FOLLOWED_MSG = "Follow successfully"
  UNFOLLOWED_MSG = "Unfollow successfully"
  CANNOT_FOLLOW_MSG = "No need to follow anymore"
  CANNOT_UNFOLLOW_MSG = "You have never been friend"

  def initialize params
    @current_user = User.find_by id: params[:follower_id]
    @friend = User.find_by id: params[:followed_id]
  end

  def follow
    if @current_user && @friend && !@current_user.following?(@friend)
      @current_user.follow(@friend)
      {status: 200, message: FOLLOWED_MSG}
    else
      {status: 400, message: CANNOT_FOLLOW_MSG}
    end
  end

  def unfollow
    if @current_user && @friend && @current_user.following?(@friend)
      @current_user.unfollow(@friend)
      {status: 200, message: UNFOLLOWED_MSG}
    else
      {status: 400, message: CANNOT_UNFOLLOW_MSG}
    end
  end
end
