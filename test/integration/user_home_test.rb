require 'test_helper'

class UserHomeTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "home display with login" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'title', full_title()
    assert_select 'h1', text: @user.name
    assert_select 'img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    assert_select 'a[href=?]', following_user_path(@user)
    assert_select '#following', "#{@user.following.count.to_s}"
    assert_select 'a[href=?]', followers_user_path(@user)
    assert_select '#followers', "#{@user.followers.count.to_s}"
  end
end
