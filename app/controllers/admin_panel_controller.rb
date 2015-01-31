class AdminPanelController < ApplicationController
  def index
    if current_user && !current_user.admin.nil? && current_user.admin
      @admin = current_user
      @posts = Post.all
      @users = User.all
      @section = Section.all
    else
      flash[:notice] = "You are not an admin! :("
      redirect_to root_path
    end
  end

  def destroy_user
    if current_user && !current_user.admin.nil? && current_user.admin
      @user = User.find(params[:id])
      @user.destroy
      redirect_to root_path
      flash[:notice] = "User destroy'd. : D"
    else
      flash[:notice] = "You are not an admin! :("
      redirect_to root_path
    end
  end
end
