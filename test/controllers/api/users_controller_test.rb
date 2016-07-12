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

    json = JSON.parse(response.body, symbolize_names: true)
    json_ids = json[:users].map{|user| user[:id]}
    json_names = json[:users].map{|user| user[:name]}
    json_emails = json[:users].map{|user| user[:email]}

    users.each do |user|
      assert json_ids.include?(user[:id])
      assert json_names.include?(user[:name])
      assert json_emails.include?(user[:email])
    end
  end

  test "should get show success responce and correct json response" do
    log_in_as(@user)
    get :show, id: @user, format: :json
    assert_response :success

    microposts = @user.microposts.paginate(page: 1)

    json = JSON.parse(response.body, symbolize_names: true)
    json_user = json[:user]
    json_ids = json[:feeds][:microposts].map{|micropost| micropost[:id]}
    json_contents = json[:feeds][:microposts].map{|micropost| micropost[:content]}

    assert_equal @user.id, json_user[:id]
    assert_equal @user.name, json_user[:name]

    microposts.each do |micropost|
      assert json_ids.include?(micropost[:id])
      assert json_contents.include?(micropost[:content])
      assert_equal @user.id, micropost[:user_id]
    end
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

    json = JSON.parse(response.body, symbolize_names: true)
    json_user = json[:user]
    json_ids = json[:following][:users].map{|user| user[:id]}
    json_names = json[:following][:users].map{|user| user[:name]}
    json_imges = json[:following][:users].map{|user| user[:img]}

    assert_equal @user.id, json_user[:id]
    assert_equal @user.name, json_user[:name]

    users.each do |user|
      assert json_ids.include?(user[:id])
      assert json_names.include?(user[:name])
      assert json_imges.include?(gravatar_url(user, size: 50))
    end
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

    json = JSON.parse(response.body, symbolize_names: true)
    json_user = json[:user]
    json_ids = json[:followers][:users].map{|user| user[:id]}
    json_names = json[:followers][:users].map{|user| user[:name]}
    json_imges = json[:followers][:users].map{|user| user[:img]}

    assert_equal @user.id, json_user[:id]
    assert_equal @user.name, json_user[:name]

    users.each do |user|
      assert json_ids.include?(user[:id])
      assert json_names.include?(user[:name])
      assert json_imges.include?(gravatar_url(user, size: 50))
    end
  end
end
