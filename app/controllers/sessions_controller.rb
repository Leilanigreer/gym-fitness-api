# sessions_controller.rb
class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:email]&.downcase)
    if user&.authenticate(params[:password])
      jwt = JWT.encode(
        { user_id: user.id, exp: 24.hours.from_now.to_i },
        Rails.application.credentials.fetch(:secret_key_base),
        "HS256"
      )
      render json: { jwt: jwt, email: user.email, user_id: user.id }, status: :created
    else
      render json: { errors: [ "Invalid email or password" ] }, status: :unauthorized
    end
  end
end
