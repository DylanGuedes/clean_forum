require 'rails_helper'

RSpec.describe Section, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section, :user => @user)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
    @post = FactoryGirl.create(:post, :user => @user, :topic => @topic)
    @other_post = Post.create(:content => 'blablabla', :user => @user, :topic => @topic)
    @topic.save
  end
  it {
    #insert new attributes here
    expect(@section).to respond_to(:name, :description, :user_id, :topics)
   }

  it { expect(@section).to be_valid }

  describe 'attributes' do
    describe 'name' do
      describe 'with less than 3 chars' do
        before { @section.name = 'aa' }
        it 'should not be valid' do
          expect(@section).not_to be_valid
        end
      end
      describe 'with more than 50 chars' do
        before { @section.name = 'a'*51 }
        it 'should not be valid' do
          expect(@section).not_to be_valid
        end
      end
      describe 'blank' do
        before { @section.name = '' }
        it 'should not be valid' do
          expect(@section).not_to be_valid
        end
      end
    end
    describe 'description' do
      describe 'with less than 10 chars' do
        before { @section.description = 'a'*8 }
        it 'should not be valid' do
          expect(@section).not_to be_valid
        end
      end
      describe 'with more than 50 chars' do
        before { @section.description = 'a'*51 }
        it 'should not be valid' do
          expect(@section).not_to be_valid
        end
      end
      describe 'blank' do
        before { @section.description = '' }
        it 'should not be valid' do
          expect(@section).not_to be_valid
        end
      end
    end

  end

  describe '#total_posts' do
    it 'should return two posts' do
      expect(@section.total_posts).to eq(2)
    end
  end
  describe '#last_post' do
    it 'should return @other_post' do
      expect(@section.last_post).to eq(@other_post)
    end
    it 'should return "empty section" if section.topics are empty' do
      new_section = Section.create(:name => 'blabla', :description => 'dadad')
      expect(new_section.last_post).to eq('Empty Section. :(')
    end
  end
end
