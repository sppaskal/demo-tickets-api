class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def seat
    "Row #{seat_row}, Seat #{seat_number}"
  end
end
