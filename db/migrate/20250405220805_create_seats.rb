class CreateSeats < ActiveRecord::Migration[8.0]
  def change
    create_table :seats do |t|
      t.references :event, null: false, foreign_key: true
      t.string :seat_row
      t.string :seat_number
      t.decimal :price
      t.boolean :reserved

      t.timestamps
    end
  end
end
