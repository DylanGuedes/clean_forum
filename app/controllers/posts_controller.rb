class PostsController < ApplicationController
  def new
    render_guard
    @topic = Topic.find(params[:id])
    print "#{@topic}*"*50
    @post = @topic.posts.build
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
