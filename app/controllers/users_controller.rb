class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    respond_to do |format|
      format.html { redirect_to root_url and return unless @user.activated? }
      format.json
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        format.html { redirect_to root_url }
        format.json { head :no_content, status: :ok }
      else
         format.html { render 'new' }
         format.json { render json: @user.errors }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        format.html { redirect_to @user }
        format.json { head :no_content, status: :ok }
      else
        format.html { render 'edit'}
        format.json { render json: @user.errors, status: :unprocessable_entry }
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content, status: :ok }
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    respond_to do |format|
      format.html { render 'show_follow' }
      format.json { render 'show_follow' }
    end
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    respond_to do |format|
      format.html { render 'show_follow' }
      format.json { render 'show_follow' }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

