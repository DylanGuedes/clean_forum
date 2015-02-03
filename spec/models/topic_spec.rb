require 'rails_helper'

RSpec.describe Topic, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
  end

  it { 
    #insert new attributes here
    expect(@topic).to respond_to(:content, :user_id, :section_id, :report_topics, :visible)
   }

  it { expect(@topic).to be_valid }

  describe 'attribute' do
    describe 'content' do
      describe 'with less than 3 chars' do
        before { @topic.content = 'aa' }
        it 'should not be valid' do
          expect(@topic).not_to be_valid
        end
      end
      describe 'with more than 9999999' do
        before { @topic.content = 'a'*9999999+'a' }
        it 'should not be valid' do
          expect(@topic).not_to be_valid
        end
      end
    end
  end

end
