class AuthController < ApplicationController
  def signup
    user = User.create!(name: params[:name], email: params[:email])
    render json: { token: user.auth_token, user: user }
  end

  def login
    user = User.find_by(email: params[:email])
    if user
      # Refresh the auth token by invoking the model's method directly
      user.update!(auth_token: SecureRandom.hex(10)) unless user.auth_token.present?
      render json: { token: user.auth_token, user: user }
    else
      render json: { error: 'Invalid email' }, status: :unauthorized
    end
  end
end
