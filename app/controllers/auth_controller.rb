class AuthController < ApplicationController
  def signup
    user = User.create!(name: params[:name], email: params[:email])
    render json: { token: user.auth_token, user: user }
  end

  def login
    user = User.find_by(email: params[:email])
    if user
      user.generate_auth_token if user.auth_token.blank?
      render json: { token: user.auth_token, user: user }
    else
      render json: { error: 'Invalid email' }, status: :unauthorized
    end
  end
end
