require 'rails_helper'

RSpec.describe Topic, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
  end

  it { 
    #insert new attributes here
    expect(@topic).to respond_to(:content, :user_id, :section_id, :report_topics, :visible, :title, :subtitle,
      :pinned)
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
    describe 'user_id' do
      before { @topic.user_id = '' }
      it 'must not allow an invalid/blank user_id' do
        expect(@topic).not_to be_valid
      end
    end
    describe 'section_id' do
      before { @topic.section_id = '' }
      it 'must not allow an invalid/blank section_id' do
        expect(@topic).not_to be_valid
      end
    end
    describe 'visible' do
      it 'must have default value true' do
        expect(@topic.visible).to eq(true)
      end 
    end
    describe 'title' do
      describe 'with less than 5 chars' do
        before { @topic.title = 'aaa' }
        it 'should not be valid' do
          expect(@topic).not_to be_valid
        end
      end
      describe 'blank' do
        before { @topic.title = '' }
        it 'should not be valid' do
          expect(@topic).not_to be_valid
        end
      end
      describe 'with more than 50 chars' do
        before { @topic.title = 'a'*51 }
        it 'should not be valid' do
          expect(@topic).not_to be_valid
        end
      end
    end
    describe 'subtitle' do
      describe 'with less than 5 chars' do
        before { @topic.subtitle = 'aaaa' }
        it 'should be valid' do
          expect(@topic).to be_valid
        end
      end
      describe 'with more than 50 chars' do
        before { @topic.subtitle = 'a'*51 }
        it 'should not be valid' do
          expect(@topic).not_to be_valid
        end        
      end
      describe 'blank' do
        before { @topic.subtitle = '' }
        it 'should be valid' do
          expect(@topic).to be_valid
        end
      end
    end
    describe 'pinned' do
      it 'must have default value false' do
        expect(@topic.pinned).to eq(false)
      end
    end
  end
end
