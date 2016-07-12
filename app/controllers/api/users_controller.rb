class Api::UsersController < Api::ApplicationController
  before_action :logged_in_user, only: [:index, :update, :destroy, :following, :followers]
  before_action :correct_user, only: :update
  before_action :admin_user, only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    user = User.new(user_params)
    if user.save
      user.send_activation_email
      render json: user, status: :created
    else
      render json: user.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    render nothing: :true, status: :ok
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      render nothing: :true, status: :bad_request unless current_user?(@user)
    end

    def admin_user
      render nothing: :true, status: :bad_request unless current_user.admin?
    end
end
