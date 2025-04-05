class AddSeatRefToTickets < ActiveRecord::Migration[8.0]
  def change
    add_reference :tickets, :seat, null: true, foreign_key: true
  end
end
