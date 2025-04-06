class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, only: [:index, :create, :update, :destroy]
  before_action :set_event, only: [:update, :destroy, :purchase_ticket]

  def index
    if @organization
      render json: @organization.events
    else
      render json: Event.all
    end
  end

  def create
    # Find the organization where the current user is the admin
    organization = Organization.find_by(admin_user_id: current_user.id)
  
    unless organization
      return render json: { error: 'Unauthorized: No associated organization found' }, status: :unauthorized
    end
  
    # Build the event under the found organization
    event = organization.events.build(event_params)
  
    if event.save
      # Generate the seat layout
      generate_seats(event, params[:rows].to_i, params[:columns].to_i, params[:price].to_d)
      render json: event, status: :created
    else
      render json: { error: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if current_user == @event.organization.admin
      @event.update!(event_params)
      render json: @event
    else
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end

  def destroy
    if current_user == @event.organization.admin
      @event.destroy
      render json: { message: "Event deleted" }
    else
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end

  def purchase_ticket
    seat = Seat.find_by(id: params[:seat_id], reserved: false)
    return render json: { error: "Seat unavailable" }, status: :unprocessable_entity unless seat
  
    ticket = Ticket.create!(user: current_user, event: @event, seat: seat)
    seat.update!(reserved: true)
    render json: ticket, status: :created
  end

  private

  def set_organization
    @organization = Organization.find_by(id: params[:organization_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :date, :location)
  end

  # Generate rectangular seat layout
  def generate_seats(event, rows, columns, price)
    row_labels = ('A'..'Z').to_a
    rows.times do |i|
      row_label = row_labels[i] || "R#{i+1}"  # fallback for beyond Z
      (1..columns).each do |num|
        Seat.create!(
          event: event,
          seat_row: row_label,
          seat_number: num.to_s,
          price: price,
          reserved: false
        )
      end
    end
  end

  # Checks if the user is the admin of an organization
  def admin_for_organization?(user)
    Organization.exists?(admin_user_id: user.id)
  end
end
