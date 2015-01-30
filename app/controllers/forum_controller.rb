class ForumController < ApplicationController
  def index
    @sections = Section.all
  end

  def help
  end

  def about
  end
end
