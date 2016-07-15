class Api::AuthenticationController < Api::ApplicationController

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      if @user.activated?
        @token = create_jwt
        render status: :created
      else
        render json: user.errors.messages, status: :unprocessable_entity
      end
    else
      render json: user.errors.messages, status: :unprocessable_entity
    end
  end

  private

    def create_jwt
      exp = Time.now.to_i + 2 * 3600
      iss = 'asuforcerails.herokuapp.com'
      payload = {id: @user.id, exp: exp, iss: iss}
      key = Rails.application.secrets[:secret_key_base]
      JWT.encode payload, key, 'HS256'
    end
end
