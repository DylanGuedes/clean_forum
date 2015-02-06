class PostsController < ApplicationController
  before_action :login_filter, only: [:new, :render_report, :create, :create_report]
  
  include ReportsHelper

  def new
    @topic = Topic.find(params[:id])
    @post = @topic.posts.build
  end

  def render_report
    @post = Post.find(params[:id])
    @report = ReportPost.new
  end

  def create_report
    shared_report "ReportPost"
  end

  def create                                                                # => need factor
    @topic = Topic.find(params[:topic_id])                                  # => need factor
    pluralized_post = @topic.posts
    #prepare_create type, type_params, pluralized_type    
    prepare_create Post, post_params, pluralized_post
  end

  def show
    @post = Post.find(params[:id])
    @posts = @post.topic.posts
    @topic = @post.topic
    render '/topics/show'
  end

  private

  def post_params
    params.require(:post).permit(:content, :topic, :user, :user_id)
  end

  def report_params
    params.require(:report_post).permit(:description, :user_id, :post, :type, :post_id)
  end

  def login_filter
    unless signed_in?
      store_location
      flash[:error] = "You are not signed in!"
      redirect_to signin_path
    end
  end
end
