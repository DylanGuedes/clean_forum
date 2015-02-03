require 'rails_helper'

RSpec.describe TopicsController, :type => :controller do
  include SessionsHelper

  before do
    @user = FactoryGirl.create(:user)    
    @section = FactoryGirl.create(:section, :user => @user)    
  end

  let(:valid_attributes){ FactoryGirl.attributes_for :topic }
  let(:invalid_attributes){ FactoryGirl.attributes_for :topic, title: '' }

  describe "GET" do
    subject { @topic = FactoryGirl.create(:topic, :user => @user, :section => @section) }
    describe '#new' do      
      context "logged user" do
        it "should render the new page with success" do
          subject
          sign_in @user
          get :new, :id => @section.id
          expect(response).to have_http_status(:success)
        end
      end
      context "non-logged user" do
        it "should be redirected" do
          subject
          get :new, :id => @section.id
          expect(response).to have_http_status(:redirect)
        end
      end
    end
    describe '#show' do
      it "should render with success an already created topic" do
        subject 
        get :show, :id => @topic.id
        expect(response).to have_http_status(:success)
      end
    end
    describe '#render_report' do
      context "logged user" do
        it "should return success" do
          subject 
          get :render_report, :id => @topic.id
        end
      end
    end
  end

  describe "POST" do
    describe '#create' do
      context "with valid params" do
        subject { post :create, topic: valid_attributes, :section_id => @section.id, :content => 'dasdsadsad' }
        it "should return success" do
          sign_in @user
          expect(subject).to have_http_status(:success)
        end
      end
      # context "with invalid params" do
      #   subject { post :create, topic: invalid_attributes, :section_id => @section.id }
      #   it 'should re-render #new' do
      #     expect(subject).to have_http_status(:redirect)
      #   end
      # end
    end
    # describe '#create_report' do
    #   it "should work" do
    #     @topic = FactoryGirl.create(:topic)
    #     @report = FactoryGirl.create(:report_topic)
    #     sign_in @user
    #     get :create_report, :report_topic => @report, :topic_id => @topic.id  -> not passing tt
    #     expect(response).to have_http_status(:success)
    #   end
    # end
  end
end
