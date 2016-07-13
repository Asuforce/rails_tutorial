require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should not get index" do
    get :index, format: :json
    assert_response :unauthorized
  end

  test "should get index succress responce and correct json response" do
    log_in_as(@user)
    get :index, format: :json
    assert_response :success

    users = User.where(activated: true).paginate(page: 1)

    pattern = {
      users: users.map {|user| {
        id: user[:id], name: user[:name], email: user[:email]
      }}.ordered!
    }
    assert_json_match pattern, response.body
  end

  test "should get show success responce and correct json response" do
    log_in_as(@user)
    get :show, id: @user, format: :json
    assert_response :success

    microposts = @user.microposts.paginate(page: 1)

    pattern = {
      user: {
        id: @user.id, name: @user.name
      },
      feeds: {
        microposts: microposts.map {|micropost| {
          id: micropost[:id], content: micropost[:content], user_id: micropost[:user_id]
        }}.ordered!
      }
    }
    assert_json_match pattern, response.body
  end

  test "invalid signup information" do
    assert_no_difference "User.count" do
      post :create, format: :json,
        user: {
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
    end
    assert_response :unprocessable_entity
  end

  test "valid signup information" do
    assert_difference "User.count", 1 do
      post :create, format: :json,
        user: {
          name: "Example User",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
      }
    end
    assert_response :created
    assert_equal 1, ActionMailer::Base.deliveries.size
  end

  test "invalid user update" do
    log_in_as(@user)
    patch :update, id: @user, format: :json,
      user: {
        name: "",
        email: "foo@invalid",
        password: "foo",
        password_confirmation: "bar"
      }
    assert_response :unprocessable_entity
  end

  test "valid user update" do
    log_in_as(@user)
    name = "Foo Bar"
    email = "foo@bar.com"

    patch :update, id: @user, format: :json,
      user: {
        name: name,
        email: email,
        password: "",
        password_confirmation: ""
      }
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
    assert_response :ok
  end

  test "should fail destroy when not logged in" do
    assert_no_difference "User.count" do
      delete :destroy, id: @user, format: :json
    end
    assert_response :unauthorized
  end

  test "should fail destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference "User.count" do
      delete :destroy, id: @user, format: :json
    end
    assert_response :bad_request
  end

  test "should success destroy" do
    log_in_as(@user)
    assert_difference "User.count", -1 do
      delete :destroy, id: @other_user, format: :json
    end
    assert_response :ok
  end

  test "should not get following success responce" do
    get :following, id: @user, format: :json
    assert_response :unauthorized
  end

  test "should get following success responce" do
    log_in_as(@user)
    get :following, id: @user, format: :json
    assert_response :ok

    users = @user.following.paginate(page: 1)

    pattern = {
      user: {
        id: @user.id, name: @user.name
      }.ignore_extra_keys!,
      following: {
        users: users.map {|user| {
          id: user[:id], name: user[:name], img: gravatar_url(user, size: 50)
        }}.ordered!
      }
    }
    assert_json_match pattern, response.body
  end

  test "should not get followers success responce" do
    get :followers, id: @user, format: :json
    assert_response :unauthorized
  end

  test "should get followers success responce" do
    log_in_as(@user)
    get :followers, id: @user, format: :json
    assert_response :ok

    users = @user.followers.paginate(page: 1)

    pattern = {
      user: {
        id: @user.id, name: @user.name
      }.ignore_extra_keys!,
      followers: {
        users: users.map {|user| {
          id: user[:id], name: user[:name], img: gravatar_url(user, size: 50)
        }}.ordered!
      }
    }
    assert_json_match pattern, response.body
  end
end
