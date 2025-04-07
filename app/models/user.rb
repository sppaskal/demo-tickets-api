class User < ApplicationRecord
  has_many :tickets
  has_one :admin_organization, class_name: 'Organization', foreign_key: 'admin_user_id'

  validates :email, presence: true, uniqueness: true

  before_create :generate_auth_token

  def generate_auth_token
    self.auth_token = SecureRandom.hex(10)
  end
end
