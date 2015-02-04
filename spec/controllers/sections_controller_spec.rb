require 'rails_helper'

RSpec.describe SectionsController, :type => :controller do
  include SessionsHelper

  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section, :user => @user)
    @admin = User.create(:login => 'novonovologin', :admin => true, :password => '123456', :password_confirmation => '123456', :email => '1234567dass@sdad.com')
    sign_in @user
  end

  let(:valid_attributes){ FactoryGirl.attributes_for :section, :user_id => @admin.id }
  let(:invalid_attributes){ FactoryGirl.attributes_for :section, :description => 'a', :user_id => @admin.id }


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
    context "with valid params" do
      subject { post :create, :section => valid_attributes }
      it "should increase total number of sections" do
        sign_out
        sign_in @admin
        expect{ subject }.to change(Section, :count).by(1)
      end
    end
    context "with invalid params" do
      subject { post :create, :section => invalid_attributes }
      it "should render new" do
        sign_out
        sign_in @admin
        subject
        expect(response).to render_template(:new)
      end
    end
  end
end
