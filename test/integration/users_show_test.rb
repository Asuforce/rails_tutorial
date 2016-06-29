class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @activate_user = users(:michael)
    @non_activate_user = users(:john)
  end

  test "redirect from non activate user page" do
    log_in_as(@activate_user)
    get user_path(@non_activate_user)
    assert_redirected_to root_url
  end
end
