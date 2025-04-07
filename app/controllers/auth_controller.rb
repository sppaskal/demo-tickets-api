class AuthController < ApplicationController
  def signup
    begin
      user = User.create!(name: params[:name], email: params[:email])
      render json: { token: user.auth_token, user: user }
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user
      user.generate_auth_token
      user.save!
      render json: { token: user.auth_token, user: user }
    else
      render json: { error: 'Invalid email' }, status: :unauthorized
    end
  end
  
end