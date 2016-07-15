module Api::SessionsHelper

  def current_user?(user)
    user == current_user
  end

  def current_user
    if (user_id = params[:id])
      @current_user ||= User.find_by_id(user_id)
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
