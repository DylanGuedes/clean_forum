require 'rails_helper'

RSpec.describe Topic, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @section = FactoryGirl.create(:section)
    @topic = FactoryGirl.create(:topic, :user => @user)
  end
end
