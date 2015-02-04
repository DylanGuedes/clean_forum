class AdminPanelController < ApplicationController
  before_action :admin_filter

  def index
    @admin = current_user
    @users = User.where(:admin => nil)
    @users += User.where(:admin => false)
    @section = Section.all
    @reports = Report.where(:pending => true)
  end

  def disapprove_report
    @report = Report.find(params[:report_id])
    unless @report.already_disapproved?  
      @report.update_attributes(:pending => false, :accepted => false, :user => current_user)
      flash[:success] = "Report disapproved!"
      redirect_to admin_path
    end
  end

  def approve_report
    @report = Report.find(params[:report_id])
    @report.pending = false
    if @report.kind_of? ReportTopic
      @report.topic.visible = false
      @report.topic.save
      flash[:success] = "Topic ##{@report.topic.id} is invisible now!"
    else
      @report.post.visible = false
      @report.post.save
      flash[:sucess] = "Post ##{@report.post.id} is invisible now!"
    end
    @report.accepted = true
    @report.save
    redirect_to root_path
  end

  def destroy_user
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
    flash[:notice] = "User destroy'd. :D"    
  end

  private
  def admin_filter
    unless signed_in? && current_user.admin
      store_location
      flash[:error] = "You are not an admin or aren't signed in!"
      redirect_to root_path
    end
  end
end
