class Api::ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include SessionsHelper

  private

    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        render nothing: :true, status: :bad_request
      end
    end
end
