require 'test_helper'

class Api::AuthenticationControllerTest < ActionController::TestCase

  def setup
    Timecop.freeze Time.new(2016,6,23,0,0,0,'+09:00')

    @user = users(:michael)
    @non_activate_user = users(:john)
  end

  def teardown
    Timecop.return
  end

  test "should fail create with non-activated user" do
    post :create, params: { email: @non_activate_user , password: 'password' }, format: :json
    assert_response :unprocessable_entity
  end

  test "should fail create with invalid password" do
    post :create, params: { email: @user.email, password: '' }, format: :json
    assert_response :unprocessable_entity
  end

  test "should success create and correct json response" do
    post :create, params: { email: @user.email, password: 'password' }, format: :json
    assert_response :success

    pattern = {
      user: {
        id: @user.id, name: @user.name, email: @user.email
      },
      token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NzYyMTQ2MTExLCJleHAiOjE0NjY2MTQ4MDAsImlzcyI6ImFzdWZvcmNlcmFpbHMuaGVyb2t1YXBwLmNvbSJ9.t3O0jl9rRayaX8hz9SUIPZRSQMmxqv-C6mUYvgWKZUo"
    }
    assert_json_match pattern, response.body
  end
end
