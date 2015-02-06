require 'rails_helper'

RSpec.describe AdminPanelController, :type => :controller do
  include SessionsHelper
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @admin = FactoryGirl.create(:user, :admin => true, :email => 'anovoemail@das.com', :login => 'adsadaaadmin')
    @section = FactoryGirl.create(:section, :user => @admin)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
    @report = FactoryGirl.create(:report, :user => @admin)
    @report_topic = FactoryGirl.create(:report_topic, :user => @admin, :topic => @topic)
    @post = FactoryGirl.create(:post, :user => @user, :topic => @topic)
    @report_post = FactoryGirl.create(:report_post, :user => @user, :post => @post)
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

  describe 'POST' do
    describe '#disapprove_report' do
      describe 'with unlogged user' do
        before { @user.admin = true ; @user.save ; sign_out } # -> the user is an admin, but isn't signed in
        subject { post :disapprove_report, :report_id => @report.id }
        it 'must redirect to root path' do
          expect(subject).to redirect_to root_path
        end
        it 'must not change the @report' do
          expect{ subject }.not_to change{ @report.pending || @report.accepted }
        end
      end
      describe "with logged user that isn't an admin" do
        subject { post :disapprove_report, :report_id => @report.id }
        it 'must redirect to root_path' do
          expect(current_user.admin).to eq(false)
          expect(subject).to redirect_to root_path
        end 
        it 'must not change the @report' do
          expect{ subject }.not_to change{ @report.pending || @report.accepted }
        end
      end
      describe 'with logged user that is an admin' do
        before { sign_out ; sign_in @admin }
        subject { post :disapprove_report, :report_id => @report.id }

        # it 'should change report pending to false' do
        #   expect(@report.pending).to eq(true)                               #  -> initial value
        #   expect{ subject }.to change{ @report.pending }                    #  -> not working tt
        # end
        it "must redirect back to admin path if the report isn't done" do
          expect(subject).to redirect_to admin_panel_path                         # -> worked
        end
      end
    end
    describe '#approve_report' do
      describe 'for a report_topic' do
        subject { post :approve_report, :report_id => @report_topic.id }
        context 'with unlogged user' do
          before { sign_out }          
          it 'must be redirected to root_path' do
            expect(subject).to redirect_to root_path
          end
          it 'must not change the report' do
            expect{ subject }.not_to change{ @report_topic }
          end
        end 
        context "with logged user that isn't an admin" do
          it 'must be returned to root_path' do
            expect(subject).to redirect_to root_path
          end
          it 'must not change the report' do
            expect{ subject }.not_to change{ @report_topic }
          end
        end
        context 'with logged user that is an admin' do
          before { sign_out ; sign_in @admin }
          it 'must change report_topic' do
            expect{ subject }.to change{ @report_topic }
          end
          it 'must be redirected to admin path' do
            expect(subject).to redirect_to admin_panel_path
          end
          # it 'must change reported topic visible to false' do
          #   put :approve_report, :report_id => @report_topic.id
          #   expect{ subject }.to change{ @report_topic }
          # end
          # it 'must change pending to false' do
          #   subject
          #   expect(@report_topic.pending).to eq(false)
          #   # expect(subject).to change(@report_topic.pending).to false
          # end
          # it 'must change accepted to true' do
          #   # expect{ subject }.to change{ @report_topic.accepted }.to true
          #   subject
          #   expect(@report_topic.accepted).to eq(true)
          # end

        end

      end
      describe 'for a report_post' do
        subject { post :approve_report, :report_id => @report_post.id }
        context 'with unlogged user' do
          before { sign_out }          
          it 'must be redirected to root_path' do
            expect(subject).to redirect_to root_path
          end
          it 'must not change the report' do
            expect{ subject }.not_to change{ @report_post }
          end
        end 
        context "with logged user that isn't an admin" do
          it 'must be returned to root_path' do
            expect(subject).to redirect_to root_path
          end
          it 'must not change the report' do
            expect{ subject }.not_to change{ @report_post }
          end
        end
        context 'with logged user that is an admin' do
          before { sign_out ; sign_in @admin }
          it 'must change report_post' do
            expect{ subject }.to change{ @report_post }
          end
          it 'must be redirected to admin path' do
            expect(subject).to redirect_to admin_panel_path
          end
        end
      end
    end
  end

  describe 'DELETE' do
    describe '#destroy_user' do
      subject { delete :destroy_user, :id => @user }
      describe 'with unlogged user' do
        before { sign_out }        
        it 'must be redirected to root_path' do
          expect(subject).to redirect_to root_path
        end
        it 'must not change total number of users' do
          expect{ subject }.not_to change(User, :count)
        end
      end
      describe "with logged user that isn't an admin" do        
        it 'must be redirected to root_path' do
          expect(subject).to redirect_to root_path
        end
        it 'must not change total number of users' do
          expect{ subject }.not_to change(User, :count)
        end
      end
      describe 'with logged user that is an admin' do
        before { sign_out ; sign_in @admin }
        it 'must decrease total number of users' do
          expect{ subject }.to change(User, :count).by(-1)
        end
        it 'must redirect to admins panel path' do
          expect(subject).to redirect_to admin_panel_path
        end
      end
    end
  end
end
