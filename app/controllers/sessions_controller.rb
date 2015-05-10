class SessionsController < ApplicationController
  before_action :login_filter, only: [:destroy]
  def new
  end

  def create
    user = User.find_by(login: params[:session][:login].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash[:error] = 'Invalid combination.'
      render 'new'
    end
  end

  def destroy
    unless !signed_in?
      sign_out
      puts "#{signed_in?}"*20
      redirect_to root_path
    end
  end
end
