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
      it "should return redirect if current_user isn't an admin" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end

    # describe '#disapprove_report' do
    #   @report = FactoryGirl.create(:report_topic)
    #   it "should return success" do
    #     get :disapprove_report, :report_id => @report
    #     expect(response).to have_http_status(:redirect)
    #   end
    # end
  end




end
