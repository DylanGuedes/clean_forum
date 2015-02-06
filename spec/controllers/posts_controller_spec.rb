require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  include SessionsHelper

  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @section = FactoryGirl.create(:section, :user => @user)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
    @post = FactoryGirl.create(:post, :user => @user, :topic => @topic)
  end

  let(:valid_attributes){ FactoryGirl.attributes_for :post, :user_id => @user.id, :topic_id => @topic.id }
  let(:valid_report){ FactoryGirl.attributes_for :report_post, :user_id => @user.id, :post_id => @post.id }
  let(:invalid_report){ FactoryGirl.attributes_for :report_post, :user_id => @user.id, :post_id => @post.id, :description => 'a' }

  describe "GET" do
    describe '#render_report' do
      subject { get :render_report, :id => @post.id }        
      context 'with logged user' do        
        before { sign_out ; sign_in @user }
        it "should return success" do
          expect(subject).to have_http_status(:success)
        end
      end
      context 'with unlogged user' do
        before { sign_out }
        it 'should be redirected to signin path' do
          expect(subject).to redirect_to signin_path
        end
      end
    end
    describe '#new' do
      subject { get :new, :id => @topic.id }
      context "with logged user" do
        it "should render #new" do
          expect(subject).to have_http_status(:success)
        end
      end
      context 'with unlogged user' do
        before { sign_out }
        it 'should be redirected to signin path' do
          expect(subject).to redirect_to signin_path
        end
      end
    end
    describe '#show' do
      subject { get :show, :id => @post.id }
      context 'with logged user' do
        it "should have http_status success and render topics show" do          
          expect(subject).to have_http_status(:success)
        end
      end
      context 'with unlogged user' do
        before { sign_out }
        it 'should have http_status success and render topics show' do
          expect(subject).to have_http_status(:success)
        end
      end
    end
  end

  describe "POST" do
    describe '#create' do
      context "with logged user that isn't an admin" do
        subject { post :create, :post => valid_attributes, :topic_id => @topic.id }
        it 'should increase total number of posts' do
          puts "#{:post}"*20
          expect{ subject }.to change(Post, :count).by(1)
        end
        it 'should be redirected to signin path' do
          expect(subject).to redirect_to Post.last             # -> create action redirect to latest post
        end
      end
      context 'with unlogged user' do
        before { sign_out }
        subject { post :create, :post => valid_attributes, :topic_id => @topic.id }
        it 'should be redirected to signin path' do
          expect(subject).to redirect_to signin_path
        end
        it 'must not change total number of posts' do
          expect{ subject }.not_to change(Post, :count)
        end
      end
    end
    describe '#create_report' do      
      context 'with logged user' do
        describe 'valid report' do
          subject { post :create_report, :report_post => valid_report }
          it 'must change total number of reports' do
            expect{ subject }.to change(Report, :count).by(1)
          end
        end
        describe 'invalid report' do
          subject { post :create_report, :report_post => invalid_report }
          it 'must not change total number of reports' do
            expect{ subject }.not_to change(Report, :count)
          end
          
        end
      end
      context 'with unlogged user' do
        before { sign_out }
        it 'must not change total number of reports' do
          expect{ subject }.not_to change(Report, :count)
        end
      end
    end
  end
end
