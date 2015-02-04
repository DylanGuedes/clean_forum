require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
include SessionsHelper

RSpec.describe SessionsHelper, :type => :helper do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe '#current_user?' do
    context 'compared with @user' do
      it 'should return true' do
        expect(current_user? @user).to eq(true)
      end
    end
  end

  # it "should return signed_in? true for a logged user" do  -> This test can't work because the session
  #   current_user = @user                                         object can't be find
  #   expect(@user.signed_in?).to eq(true)
  # end

  # it "should redirect_to root_path if the user isn't signed_in" do        -> Method redirect_to can't work in a non-controller class
  #   sign_out
  #   render_guard
  # end

end
