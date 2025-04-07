class Event < ApplicationRecord
  belongs_to :organization
  has_many :tickets
  has_many :seats

  validates :name, presence: true, uniqueness: true

  # Generate rectangular seat layout
  def generate_seats(rows, columns, price)
    row_labels = ('A'..'Z').to_a
    rows.times do |i|
      row_label = row_labels[i] || "R#{i + 1}" # fallback for beyond Z
      (1..columns).each do |num|
        self.seats.create!(
          seat_row: row_label,
          seat_number: num.to_s,
          price: price,
          reserved: false
        )
      end
    end
  end
end
