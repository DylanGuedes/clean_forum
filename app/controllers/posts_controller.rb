class PostsController < ApplicationController
  before_action :login_filter, only: [:new, :render_report, :create, :create_report]
  include ReportsHelper

  def new
    @topic = Topic.find(params[:id])
    print "#{@topic}*"*50
    @post = @topic.posts.build
  end

  def render_report
    @post = Post.find(params[:id])
    @report = ReportPost.new
  end

  def create_report
    shared_report "ReportPost"
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      flash[:notice] = "invalid post. :("
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @posts = @post.topic.posts
    @topic = @post.topic
    render '/topics/show'
  end

  private

  def post_params
    params.require(:post).permit(:content, :topic, :user)
  end

  def report_params
    params.require(:report_post).permit(:description, :user, :post, :type, :post_id)
  end
end
