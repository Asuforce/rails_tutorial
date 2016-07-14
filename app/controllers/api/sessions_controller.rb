class Api::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:auth][:email].downcase)
    if user && user.authenticate(params[:auth][:password])
      if user.activated?
        render status: :created
      else
        render json: user.errors.messages, status: :unprocessable_entity
      end
    else
      render json: user.errors.messages, status: :unprocessable_entity
    end
  end
end
