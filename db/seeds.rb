# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

org = Organization.create!(name: "Dream Events")
event = org.events.create!(name: "RubyConf 2025", date: DateTime.new(2025, 11, 15, 9), location: "Edmonton")
user = User.create!(name: "Jane Doe", email: "jane@example.com")
event.tickets.create!(seat_row: "A", seat_number: "12", price: 199.99, user: user)
