require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @dupped_user = @user.dup
    @valid_user = User.create(:login => 'forbiddenlogin2', :password => 'forbpass2', :password_confirmation => 'forbpass2')
  end

  it {
      #insert new attributes here
      expect(@user).to respond_to(:name, :email, :login, :password, :password_confirmation, :posts,
        :report_topics, :report_posts, :topics, :admin)
     }
  it { expect(@user).to be_valid }

  describe 'attributes' do
    describe 'login' do
      describe 'with less than 5 chars' do        
        before { @user.login = 'aaa' }
        it 'should not be valid' do
          expect(@user).not_to be_valid
        end
      end
      describe 'with more than 50 chars' do
        before { @user.login = 'aaa'*50 }
        it 'should not be valid' do
          expect(@user).not_to be_valid
        end
      end
      describe 'already taken' do
        before { @dupped_user.save }
        it { expect(@dupped_user).not_to be_valid }
      end
    end
    describe 'name' do
      describe 'with less than 5 chars' do
        before { @user.name = 'aaa' }
        it 'should be valid' do
          expect(@user).to be_valid
        end
      end
      describe 'with more than 50 chars' do
        before { @user.name = 'aaa'*50 }
        it 'should not be valid' do
          expect(@user).not_to be_valid
        end
      end
      describe 'already taken' do
        before { @valid_user.name = @user.name }
        it 'should be valid' do
          expect(@valid_user).to be_valid
        end
      end      
    end    
  end
end
