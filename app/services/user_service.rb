class UserService
  VALID_ACTION = ["sleep", "wakeup"]
  INVALID_ACTION_MSG = "Your action is not valid"

  def initialize params
    @user = User.find params[:id]
    @action = params[:user_action]
  end

  def take_action
    if valid_action?
      {status: 200, message: @user.send(@action)}
    else
      {status: 400, message: INVALID_ACTION_MSG}
    end
  end

  def valid_action?
    @action.in? VALID_ACTION
  end
end
