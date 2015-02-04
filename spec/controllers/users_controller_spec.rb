require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  include SessionsHelper

  before do
    @user = FactoryGirl.create(:user)
  end

  let(:valid_attributes){ FactoryGirl.attributes_for :user, login: 'anotherloginnow', email: 'umemailnovo@emailnovo.com' }

  describe "GET" do
    describe '#new' do
      it "should have http_status success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
    describe '#index' do
      context 'signed user' do
        it "should have http_status success" do
          sign_in @user
          get :index
          expect(response).to have_http_status(:success)
        end
      end
      context 'non-signed user' do
        it 'should be redirected to signin path' do
          get :index
          expect(response).to have_http_status(:redirect)
        end
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
      context 'with valid params' do
        subject { post :create, :user => valid_attributes }
        it "should create user if the params are correct" do
          subject
          expect(get :show, :id => User.last.id).to have_http_status(:success)
        end
        it "should increase total number of users" do
          expect { subject }.to change(User, :count).by(1)
        end
      end
      context 'with invalid params' do
        it "should not create user with invalid params" do
          post :create, :user => { :login => @user.login, :password => 'anewuserpassword', :password_confirmation => 'anewuserpassword' }
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
