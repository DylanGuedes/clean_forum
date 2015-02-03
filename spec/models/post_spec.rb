require 'rails_helper'

RSpec.describe Post, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section, :user => @user)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
    @post = FactoryGirl.create(:post, :user => @user, :topic => @topic)
  end

  it { 
      #insert new attributes here
      expect(@post).to respond_to(:content, :user_id, :topic_id, :report_posts, :visible)
     }

  it { expect(@post).to be_valid }

  describe 'attribute' do
    describe 'content' do
      describe 'with less than 2 chars' do
        before { @post.content = 'a' }
        it 'should not be valid' do
          expect(@post).not_to be_valid
        end
      end
      describe 'with more than 999999 chars' do
        before { @post.content = 'a'*999999+'a' }
        it 'should not be valid' do
          expect(@post).not_to be_valid
        end
      end
    end
    describe 'user_id' do
      describe 'invalid' do
        before { @post.user_id = '' }
        it 'should not be valid' do
          expect(@post).not_to be_valid
        end
      end
    end
    describe 'topic_id' do
      describe 'blank or invalid' do
        before { @post.topic_id = '' }
        it 'should not be valid' do
          expect(@post).not_to be_valid
        end
      end
    end
    describe 'visible' do
      it 'must have default value true' do
        expect(@post.visible).to eq(true)
      end
    end
  end
end
