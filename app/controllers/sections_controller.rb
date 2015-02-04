class SectionsController < ApplicationController
  before_action :admin_filter, only: [:new, :create]

  def show
    @section = Section.find(params[:id])
    @topics = @section.topics.where(:visible => true)
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section created!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  def section_params
    params.require(:section).permit(:name, :description, :user_id)
  end

  def admin_filter
    unless signed_in? && current_user.admin
      store_location
      flash[:error] = "You are not an admin or aren't signed in!"
      redirect_to root_path
    end
  end
end
