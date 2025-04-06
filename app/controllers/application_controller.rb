class ApplicationController < ActionController::API
  def current_user
    token = request.headers['Authorization']
    return nil unless token

    @current_user ||= User.find_by(auth_token: token)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end