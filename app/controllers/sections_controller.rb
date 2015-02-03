class SectionsController < ApplicationController
  def show
    @section = Section.find(params[:id])
    @topics = @section.topics.where(:visible => true)
  end

  def new
    if signed_in? && current_user.admin
      @section = Section.new
    else
      flash[:notice] = "You aren't an admin. :("
      redirect_to root_path
    end
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
    params.require(:section).permit(:name, :description)
  end
end
