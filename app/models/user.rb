class User < ApplicationRecord
  has_many :tickets
  has_one :admin_organization, class_name: 'Organization', foreign_key: 'admin_user_id'
end
