class Event < ApplicationRecord
  belongs_to :organization
  has_many :tickets
  has_many :seats

  validates :name, presence: true, uniqueness: true
end
