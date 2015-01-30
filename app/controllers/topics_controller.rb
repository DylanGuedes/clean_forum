class TopicsController < ApplicationController
  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts
  end

  def new
    render_guard
    @section = Section.find(params[:id])
    @topic = Topic.new
  end

  def create
    render_guard
    @section = Section.find(params[:section_id])
    @topic = @section.topics.build(topic_params)
    @post = @topic.posts.build(:content => @topic.content_for_posts)
    @post.user = current_user
    @topic.user = current_user
    if @topic.save && @post.save
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
end
