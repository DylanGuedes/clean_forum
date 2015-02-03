require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
  end

  it {
      #insert new attributes here
      expect(@user).to respond_to(:name, :email, :login, :password, :password_confirmation, :posts,
        :report_topics, :report_posts, :topics, :admin)
     }

end
