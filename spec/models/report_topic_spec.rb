require 'rails_helper'

RSpec.describe ReportTopic, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section, :user => @user)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
    @report_topic = FactoryGirl.create(:report_topic, :user => @user, :topic => @topic)
  end

  it {
      #insert new attributes here
      expect(@report_topic).to respond_to(:description, :user_id, :topic_id, :user, :topic)
     }
  it { expect(@report_topic).to be_valid }

  describe 'attribute' do
    describe 'description' do
      describe 'with less than 15 chars' do
        before { @report_topic.description = 'a'*14 }
        it 'should not be valid' do
          expect(@report_topic).not_to be_valid
        end
      end
      describe 'with more than 500 chars' do
        before { @report_topic.description = 'a'*501 }
        it 'should not be valid' do
          expect(@report_topic).not_to be_valid
        end
      end
    end
    describe 'user_id' do
      describe 'blank or invalid' do
        before { @report_topic.user_id = '' }
        it 'should not be allowed' do
          expect(@report_topic).not_to be_valid
        end
      end
    end
    describe 'topic_id' do
      describe 'blank or invalid' do
        before { @report_topic.topic_id = '' }
        it 'should not be allowed' do
          expect(@report_topic).not_to be_valid
        end
      end
    end
  end
end
