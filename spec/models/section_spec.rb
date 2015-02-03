require 'rails_helper'

RSpec.describe Section, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
    @post = FactoryGirl.create(:post, :user => @user, :topic => @topic)
    @other_post = Post.create(:content => 'blablabla', :user => @user, :topic => @topic)
    @topic.save
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
