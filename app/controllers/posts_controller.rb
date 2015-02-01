class PostsController < ApplicationController
  def new
    render_guard
    @topic = Topic.find(params[:id])
    print "#{@topic}*"*50
    @post = @topic.posts.build
  end

  def render_report
    @post = Post.find(params[:id])
    @report = ReportPost.new
  end

  def create_report
    @report = ReportPost.new(report_params)
    if @report.save
      flash[:notice] = "Report created"
      redirect_to root_path
    else
      flash[:notice] = "Invalid report"
      render 'render_report'      
    end    
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
end
