class AdminPanelController < ApplicationController
  def index
    if current_user && !current_user.admin.nil? && !current_user.admin
      @admin = current_user
    else
      flash[:notice] = "You are not an admin! :("
      redirect_to root_path
    end
  end
end
