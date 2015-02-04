require 'rails_helper'

RSpec.describe AdminPanelController, :type => :controller do
  include SessionsHelper
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET" do
    describe '#index' do      
      it "should return success if current_user is logged and and is an admin" do
        @user.admin = true
        @user.save
        get :index
        expect(response).to have_http_status(:success)
      end
      it "should redirect if the current_user isn't an admin but is logged" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
      it "should redirect if the user isn't logged" do
        @user.admin = true
        @user.save                # -> the user is an admin
        sign_out
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end
  end


end
