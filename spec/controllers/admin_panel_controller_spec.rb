require 'rails_helper'

RSpec.describe AdminPanelController, :type => :controller do
  include SessionsHelper
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @admin = FactoryGirl.create(:user, :admin => true, :email => 'anovoemail@das.com', :login => 'adsadaaadmin')
    @section = FactoryGirl.create(:section, :user => @admin)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
    @report = FactoryGirl.create(:report, :user => @user)
  end

  describe "GET" do
    subject { get :index }
    describe '#index' do      
      it "should return success if current_user is logged and and is an admin" do
        @user.admin = true
        @user.save
        expect(subject).to have_http_status(:success)
      end
      it "should redirect if the current_user isn't an admin but is logged" do
        get :index
        expect(subject).to have_http_status(:redirect)
      end
      it "should redirect if the user isn't logged" do
        @user.admin = true
        @user.save                # -> the user is an admin
        sign_out                  # -> the user isn't logged
        get :index
        expect(subject).to have_http_status(:redirect)
      end
    end
  end

  describe 'PUT' do
    describe '#disapprove_report' do
      describe 'with unlogged user' do
        before { @user.admin = true ; @user.save ; sign_out } # -> the user is an admin, but isn't signed in
        subject { put :disapprove_report, :report_id => @report.id }
        it 'must redirect to root path' do
          expect(subject).to redirect_to root_path
        end
        it 'must not change the @report' do
          expect{ subject }.not_to change{ @report.pending || @report.accepted }
        end
      end
      describe "with logged user that isn't an admin" do
        subject { get :disapprove_report, :report_id => @report.id }
        it 'must redirect to root_path' do
          expect(current_user.admin).to eq(false)
          expect(subject).to redirect_to root_path
        end 
        it 'must not change the @report' do
          expect{subject}.not_to change{ @report.pending || @report.accepted }
        end
      end
      describe 'with logged user that is an admin' do
        before { sign_out ; sign_in @admin }
        subject { put :disapprove_report, :report_id => @report.id }
        it 'must redirect back to admin path' do
          expect(subject).to redirect_to admin_path
        end
        it 'should change report pending to false' do
          expect(@report.pending).to eq(true)                               #  -> initial value
          expect{ subject }.to change{ @report.pending }                    #  -> not working tt
        end
      end
    end
  end


end
