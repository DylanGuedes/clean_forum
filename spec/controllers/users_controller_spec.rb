require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe "GET" do
    describe '#new' do
      it "should have http_status success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
    describe '#index' do
      it "should have http_status success" do
        sign_in @user
        get :index
        expect(response).to have_http_status(:success)
      end
    end
    describe '#show' do
      it "should have http_status success if the user exist" do
        get :show, :id => @user.id
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST" do
    describe '#create' do
      it "should create user if the params are correct" do
        post :create, :user => { :login => 'anewusertest', :password => 'anewuserpassword', :password_confirmation => 'anewuserpassword' }
        expect(get :show, :id => User.last.id).to have_http_status(:success)
      end
      it "should not create user with invalid params" do
        post :create, :user => { :login => @user.login, :password => 'anewuserpassword', :password_confirmation => 'anewuserpassword' }
        expect(response).to render_template(:new)
      end
    end
  end
end
