require 'rails_helper'

RSpec.describe Report, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section, :user => @user)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
    @post = FactoryGirl.create(:post, :user => @user, :topic => @topic)
    @report = FactoryGirl.create(:report, :user => @user)
  end

  it {
      #insert new attributes here
      expect(@report).to respond_to(:description, :user_id, :user)
     }
  it { expect(@report).to be_valid }

  describe 'attribute' do
    describe 'description' do
      describe 'with less than 15 chars' do
        before { @report.description = 'a'*14 }
        it 'should not be valid' do
          expect(@report).not_to be_valid
        end
      end
      describe 'with more than 500 chars' do
        before { @report.description = 'a'*501 }
        it 'should not be valid' do
          expect(@report).not_to be_valid
        end
      end
    end
    describe 'user_id' do
      describe 'blank or invalid' do
        before { @report.user_id = '' }
        it 'should not be allowed' do
          expect(@report).not_to be_valid
        end
      end
    end
  end
end
