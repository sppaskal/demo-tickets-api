'''
If seeding fails, reset the db completely by:
1. Delete development.sqlite3 and test.sqlite3 files
2. Run: rails db:create db:migrate db:seed
'''

# Clear existing data
Ticket.delete_all
Seat.delete_all
Event.delete_all
Organization.delete_all
User.delete_all

# Create users (admin + regular)
admin1 = User.create!(name: 'Alice Admin', email: 'alice@example.com', auth_token: 'token123')
admin2 = User.create!(name: 'Bob Admin', email: 'bob@example.com', auth_token: 'token456')
admin3 = User.create!(name: 'Carol Admin', email: 'carol@example.com', auth_token: 'token789')

user1 = User.create!(name: 'Dave User', email: 'dave@example.com', auth_token: 'user1token')
user2 = User.create!(name: 'Eve User', email: 'eve@example.com', auth_token: 'user2token')
user3 = User.create!(name: 'Frank User', email: 'frank@example.com', auth_token: 'user3token')
user4 = User.create!(name: 'Grace User', email: 'grace@example.com', auth_token: 'user4token')
user5 = User.create!(name: 'Heidi User', email: 'heidi@example.com', auth_token: 'user5token')

# Create organizations with admins
org1 = Organization.create!(name: 'Alpha Org', admin_user_id: admin1.id)
org2 = Organization.create!(name: 'Beta Org', admin_user_id: admin2.id)
org3 = Organization.create!(name: 'Gamma Org', admin_user_id: admin3.id)

# Create events
event1 = Event.create!(name: 'Spring Festival', date: '2025-05-10', location: 'New York', organization_id: org1.id)
event2 = Event.create!(name: 'Summer Jam', date: '2025-07-22', location: 'Los Angeles', organization_id: org1.id)

event3 = Event.create!(name: 'Tech Expo', date: '2025-06-15', location: 'San Francisco', organization_id: org2.id)
event4 = Event.create!(name: 'Art Gala', date: '2025-08-01', location: 'Chicago', organization_id: org2.id)

event5 = Event.create!(name: 'Gaming Con', date: '2025-09-20', location: 'Seattle', organization_id: org3.id)
event6 = Event.create!(name: 'Book Fair', date: '2025-10-05', location: 'Boston', organization_id: org3.id)

# Create seats
def create_seats_for_event(event)
  [
    ['A', '1', 50.00],
    ['A', '2', 50.00],
    ['B', '1', 45.00],
    ['B', '2', 45.00],
    ['C', '1', 40.00]
  ].each do |row, number, price|
    Seat.create!(
      event_id: event.id,
      seat_row: row,
      seat_number: number,
      price: price,
      reserved: false
    )
  end
end

[event1, event2, event3, event4, event5, event6].each do |event|
  create_seats_for_event(event)
end

# Reserve a few seats by creating tickets
def reserve_seat(user, seat)
  Ticket.create!(
    seat_row: seat.seat_row,
    seat_number: seat.seat_number,
    price: seat.price,
    user_id: user.id,
    event_id: seat.event_id,
    seat_id: seat.id
  )
  seat.update!(reserved: true)
end

# Assign some tickets to users
reserve_seat(user1, Seat.find_by(event_id: event1.id, seat_row: 'A', seat_number: '1'))
reserve_seat(user2, Seat.find_by(event_id: event1.id, seat_row: 'B', seat_number: '1'))
reserve_seat(user3, Seat.find_by(event_id: event3.id, seat_row: 'C', seat_number: '1'))
reserve_seat(user4, Seat.find_by(event_id: event5.id, seat_row: 'A', seat_number: '2'))
reserve_seat(user5, Seat.find_by(event_id: event6.id, seat_row: 'B', seat_number: '2'))

put "Seeding completed!"