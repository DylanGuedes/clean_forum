class SectionsController < ApplicationController
  def show
    @section = Section.find(params[:id])
    @topics = @section.topics
  end
end
