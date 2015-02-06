module ReportsHelper
  def shared_report type
    if type == "ReportTopic"
      @report = ReportTopic.new(report_params)   
    elsif type == "ReportPost"
      @report = ReportPost.new(report_params)
    end
    save_report @report
  end

  def save_report report
    if report.save
      flash[:notice] = "Report created."
      redirect_to current_user
    else
      flash[:notice] = "Invalid report"
      render 'render_report'      
    end
  end
end
