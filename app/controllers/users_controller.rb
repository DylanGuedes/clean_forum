class UsersController < ApplicationController
  before_action :login_filter, only: [:edit, :update, :index]
  # before_action :owner_filter, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user
    else
      flash[:error] = "Invalid!"
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = "Done!"
    else
      flash[:error] = "Error!"
    end
    redirect_to edit_profile_path
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :login, :email, :password, :password_confirmation)
  end

  def owner_filter
    @user = User.find(params[:id])
    redirect_to root_path unless current_user? @user
  end
end
