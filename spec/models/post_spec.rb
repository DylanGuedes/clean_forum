require 'rails_helper'

RSpec.describe Post, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section)
    @topic = FactoryGirl.create(:topic, :user => @user, :section => @section)
    @post = FactoryGirl.create(:post, :user => @user, :topic => @topic)
  end

  it { expect(@user).to be_valid }
end
