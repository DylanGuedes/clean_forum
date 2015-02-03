class TopicsController < ApplicationController
  before_action :login_filter, only: [:create, :new, :render_report, :create_report]

  include ReportsHelper

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts
    @posts = @posts.where(:visible => true)
  end

  def new
    @section = Section.find(params[:id])
    @topic = Topic.new
  end

  def render_report
    @topic = Topic.find(params[:id])
    @report = @topic.report_topics.build
  end

  def create_report
    shared_report "ReportTopic"
  end

  def create
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

  def login_filter
    unless signed_in?
      store_location
      flash[:error] = "You are not signed in!"
      redirect_to signin_path
    end
  end
end
