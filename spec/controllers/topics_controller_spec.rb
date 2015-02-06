require 'rails_helper'

RSpec.describe TopicsController, :type => :controller do
  include SessionsHelper

  before do
    @user = FactoryGirl.create(:user)    
    @section = FactoryGirl.create(:section, :user => @user)    
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
  end

  let(:valid_attributes){ FactoryGirl.attributes_for :topic, :user_id => @user.id, :title => 'umtitutloqualq', :section_id => @section.id }
  let(:invalid_attributes){ FactoryGirl.attributes_for :topic, title: 'aa', :user_id => @user.id, :section_id => @section.id, :content => 'a'*50 }
  let(:valid_report){ FactoryGirl.attributes_for :report_topic, :user_id => @user.id, :topic_id => @topic.id }
  let(:invalid_report){ FactoryGirl.attributes_for :report_topic, :user_id => @user.id, :topic_id => @topic.id, :description => 'a' }

  describe "GET" do
    describe '#new' do      
      context "logged user" do
        it "should render the new page with success" do
          sign_in @user
          get :new, :id => @section.id
          expect(response).to have_http_status(:success)
        end
      end
      context "non-logged user" do
        it "should be redirected" do
          get :new, :id => @section.id
          expect(response).to have_http_status(:redirect)
        end
      end
    end
    describe '#show' do
      it "should render with success an already created topic" do
        get :show, :id => @topic.id
        expect(response).to have_http_status(:success)
      end
    end
    describe '#render_report' do
      context "logged user" do
        it "should return success" do
          sign_in @user
          get :render_report, :id => @topic.id
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  describe "POST" do
    describe '#create' do
      context "with valid params" do
        subject { post :create, topic: valid_attributes, :section_id => @section.id }
        it "should increase total number of topics" do
          sign_in @user
          expect{ subject }.to change(Topic, :count).by(1)
        end
      end
      context "with invalid params" do
        before { sign_in @user }
        subject { post :create, topic: invalid_attributes, :section_id => @section.id }
        it 'should not increase total number of topics' do
          expect{ subject }.not_to change(Topic, :count)
        end
      end
    end
    describe '#create_report' do      
      describe 'with unlogged user' do
        subject { post :create_report, :report_topic => valid_report }
        before { sign_in @user ; sign_out }                               # -> the user is signed in and out        
        it 'must be redirected to signin_path' do
          expect(subject).to redirect_to signin_path
        end
        it 'must not change the reports count' do
          expect{ subject }.not_to change(Report, :count)
        end
      end
      describe "with logged user that isn't an admin" do
        before { sign_in @user }
        describe 'with valid report' do
          subject { post :create_report, :report_topic => valid_report }          
          it 'must change total number of reports' do
            expect{ subject }.to change(Report, :count)
          end
        end
        describe 'with invalid report' do
          subject { post :create_report, :report_topic => invalid_report }
          it 'must not change total number of reports' do
            expect{ subject }.not_to change(Report, :count)
          end 
        end
      end
    end
  end
end
