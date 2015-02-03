require 'rails_helper'

RSpec.describe SectionsController, :type => :controller do
  include SessionsHelper

  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section, :user => @user)
    sign_in @user
  end

  describe "GET" do
    describe '#show' do
      it "should have http_status success for a valid section" do
        get :show, :id => @section.id
        expect(response).to have_http_status(:success)
      end
    end
    describe '#new' do
      context "with valid params" do
        it "should render new if the current_user is an admin and is logged" do
          @user.admin = true
          @user.save
          get :new
          expect(response).to have_http_status(:success)
        end
      end
      context "with invalid params" do
        it "should not redirect_to sections new page" do
          get :new
          expect(response).to have_http_status(:redirect)
        end
      end
    end
  end

  describe "POST #create" do
    # context "with valid params" do
    #   it "should return the last section if the section was created" do
    #     post :create, :section => { :name => 'Randomname', :description => 'Randomdescription', :user => @user }
    #     expect(Section.last).to eq(Section.find_by(:name => 'Randomname'))
    #   end
    # end
    context "with invalid params" do
      it "should render new" do
        post :create, :section => { :name => '', :description => '' }
        expect(response).to render_template(:new)
      end
    end
  end
end
