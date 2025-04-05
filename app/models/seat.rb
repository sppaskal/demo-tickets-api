class Seat < ApplicationRecord
  belongs_to :event
  has_one :ticket

  def reserved?
    !!self.reserved
  end
end
