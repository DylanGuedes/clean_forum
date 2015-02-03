require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = FactoryGirl.create(:user)
    @dupped_user = @user.dup
    @valid_user = User.create(:email => 'a@a.com', :login => 'forbiddenlogin2', :password => 'forbpass2', :password_confirmation => 'forbpass2')
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
    describe 'email' do
      describe 'with less than 8 chars' do
        before { @valid_user.email = 'a'+'@a.com' }
        it 'should be valid' do
          expect(@valid_user).to be_valid
        end
      end
      describe 'with more than 50 chars' do
        before { @user.email = 'aaa'*50+'@teste.com' }
        it 'should be valid' do
          expect(@user).to be_valid
        end
      end
      describe 'already taken' do
        before { @valid_user.email = @user.email }
        it 'should not be valid' do
          expect(@valid_user).not_to be_valid
        end
      end
      describe 'with wrong regex' do
        it 'should not be valid' do
          addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
          addresses.each do |invalid_regex|
            @user.email = invalid_regex
            expect(@user).not_to be_valid
          end
        end
      end
    end
    describe 'password and password_confirmation' do
      describe 'with less than 5 chars' do
        before { @user.password = 'aaa' ; @user.password_confirmation = 'aaa' }
        it 'should not be valid' do
          expect(@user).not_to be_valid
        end
      end
      describe 'with more than 100 chars' do
        before { @user.password = 'aaa'*100 ; @user.password_confirmation = 'aaa'*100 }
        it 'should not be valid' do
          expect(@user).not_to be_valid
        end
      end
      describe 'not match with password_confirmation' do
        before { @user.password = 'umpass' ; @user.password_confirmation = 'outropass' }
        it 'should not be valid' do
          expect(@user).not_to be_valid
        end
      end
      describe 'already taken' do
        before { @valid_user.password = @user.password ; @valid_user.password_confirmation = @user.password }
        it 'should be valid' do
          expect(@valid_user).to be_valid
        end
      end
    end  
  end
end
