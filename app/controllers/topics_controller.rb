class TopicsController < ApplicationController
  include ReportsHelper
  include SessionsHelper


  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts
    @posts = @posts.where(:visible => true)
  end

  def new
    render_guard
    @section = Section.find(params[:id])
    @topic = Topic.new
  end

  def render_report
    render_guard
    @topic = Topic.find(params[:id])
    @report = @topic.report_topics.build
  end

  def create_report
    shared_report "ReportTopic"
  end

  def create
    render_guard
    @section = Section.find(params[:section_id])
    @topic = @section.topics.build(topic_params)
    @topic.user = current_user
    if @topic.save
      redirect_to @topic
    else
      flash[:error] = "invalid topic. :("
      render 'new'
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :subtitle, :section, :content_for_posts)
  end

  def report_params
    params.require(:report_topic).permit(:description, :user, :topic, :type, :topic_id)
  end
end
