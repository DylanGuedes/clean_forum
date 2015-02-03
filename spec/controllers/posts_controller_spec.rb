require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  include SessionsHelper

  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @post = FactoryGirl.create(:post)
    @topic = FactoryGirl.create(:topic)
  end

  describe "GET" do
    describe '#render_report' do
      it "should return success" do
        get :render_report, :id => @post.id
        expect(response).to have_http_status(:success)
      end
    end
    describe '#new' do
      context "with valid params" do
        it "should render #new" do
          get :new, :id => @topic.id
          expect(response).to have_http_status(:success)
        end
      end
    end
    describe '#show' do
      it "should have http_status success and render topics show" do
        @post.topic = @topic
        @topic.posts.push @post
        @post.save
        @topic.save
        get :show, :id => @post.id
        expect(response).to render_template('topics/show')
      end
    end
  end
end
