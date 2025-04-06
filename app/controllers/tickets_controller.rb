class TicketsController < ApplicationController

  before_action :authenticate_user!

  def create
    seat = Seat.find_by(id: params[:seat_id], event_id: params[:event_id])

    if seat.nil?
      return render json: { error: 'Seat not found for this event' }, status: :not_found
    end

    if seat.reserved
      return render json: { error: 'Seat already reserved' }, status: :unprocessable_entity
    end

    # Transaction ensures consistency between reserving seat and creating ticket
    ActiveRecord::Base.transaction do
      seat.update!(reserved: true)

      ticket = Ticket.create!(
        user: current_user,
        event_id: seat.event_id,
        seat_id: seat.id,
        seat_row: seat.seat_row,
        seat_number: seat.seat_number,
        price: seat.price
      )

      render json: ticket, status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
