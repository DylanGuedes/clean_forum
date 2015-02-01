class AdminPanelController < ApplicationController
  def index
    if current_user && !current_user.admin.nil? && current_user.admin
      @admin = current_user
      @users = User.where(:admin => nil)
      @users += User.where(:admin => false)
      @section = Section.all
      @reports = Report.where(:pending => true)
    else
      flash[:notice] = "You are not an admin! :("
      redirect_to root_path
    end
  end

  def disapprove_report
    @report = Report.find(params[:report_id])
    @report.pending = false
    @report.accepted = false
    @report.save
    flash[:success] = "Report disapproved!"
    redirect_to root_path
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
