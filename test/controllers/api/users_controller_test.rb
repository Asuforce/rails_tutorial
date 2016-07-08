require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get success responce" do
#    log_in_as(@user)
#    get api_users_path
#    assert_equal 200, responce.status
  end
end
