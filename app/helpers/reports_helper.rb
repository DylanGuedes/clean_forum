module ReportsHelper
  def shared_report type
    render_guard
    if type == "ReportTopic"
      @report = ReportTopic.new(report_params)
      @report.topic = Topic.find(params[:topic_id])      
    elsif type == "ReportPost"
      @report = ReportPost.new(report_params)
      @report.post = Post.find(params[:post_id])
    end
    @report.user = current_user
    save_report @report
  end

  def save_report report
    if report.save
      flash[:notice] = "Report created."
      redirect_to root_path
    else
      flash[:notice] = "Invalid report"
      render 'render_report'
    end
  end
end
