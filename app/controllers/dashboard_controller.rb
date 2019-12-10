class DashboardController < ActionController::Base
  layout "user_layout"
  def index
    respond_to do |format|
      format.html  # index.html.erb
      # format.json  { render :json => @posts }
      format.js
    end
  end
end
