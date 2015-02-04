require 'rails_helper'

RSpec.describe ReportPost, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section, :user => @user)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
    @post = FactoryGirl.create(:post, :user => @user, :topic => @topic)
    @report_post = FactoryGirl.create(:report_post, :user => @user, :post => @post)
  end

  it {
      #insert new attributes here
      expect(@report_post).to respond_to(:description, :user_id, :post_id, :user, :post)
     }
  it { expect(@report_post).to be_valid }

  describe 'attribute' do
    describe 'description' do
      describe 'with less than 15 chars' do
        before { @report_post.description = 'a'*14 }
        it 'should not be valid' do
          expect(@report_post).not_to be_valid
        end
      end
      describe 'with more than 500 chars' do
        before { @report_post.description = 'a'*501 }
        it 'should not be valid' do
          expect(@report_post).not_to be_valid
        end
      end
    end
    describe 'user_id' do
      describe 'blank or invalid' do
        before { @report_post.user_id = '' }
        it 'should not be allowed' do
          expect(@report_post).not_to be_valid
        end
      end
    end
    describe 'post_id' do
      describe 'blank or invalid' do
        before { @report_post.post_id = '' }
        it 'should not be allowed' do
          expect(@report_post).not_to be_valid
        end
      end
    end
  end
end
