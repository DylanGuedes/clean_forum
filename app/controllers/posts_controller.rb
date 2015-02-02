class PostsController < ApplicationController
  include ReportsHelper

  def new
    render_guard
    @topic = Topic.find(params[:id])
    print "#{@topic}*"*50
    @post = @topic.posts.build
  end

  def render_report
    render_guard
    @post = Post.find(params[:id])
    @report = ReportPost.new
  end

  def create_report
    shared_report "ReportPost"
  end

  def create
    render_guard
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
