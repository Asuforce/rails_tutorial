ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'json_expressions/minitest'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  fixtures :all
  include ApplicationHelper
  include UsersHelper

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, params: { session: { email: user.email, password: password, remember_me: remember_me }}
    else
      session[:user_id] = user.id
    end
  end

  def set_headers(user)
    token = user.create_jwt
    @request.headers["Authorization"] = "Bearer #{token}"
  end

  private

    def integration_test?
      defined?(post_via_redirect)
    end
end
