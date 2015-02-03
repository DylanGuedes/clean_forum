require 'rails_helper'

RSpec.describe TopicsController, :type => :controller do
  include SessionsHelper

  before do
    @section = FactoryGirl.create(:section)
    @user = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic)
  end

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
          get :render_report, :id => @topic.id
        end
      end
    end
  end

  describe "POST" do
    describe '#create' do
      context "with valid params" do
        it "should return success" do
          sign_in @user
          post :create, :topic => { :title => @topic.title, :subtitle => @topic.subtitle, :section => @section, :content_for_posts => @topic.content_for_posts }, :section_id => @section.id, :content => @topic.content_for_posts
          expect(response).to have_http_status(:success)

        end

      end

    end

  end
end
