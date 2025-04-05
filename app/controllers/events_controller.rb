class EventsController < ApplicationController
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
    admin = @organization.admin
    if current_user == admin
      event = @organization.events.create!(event_params)
      render json: event, status: :created
    else
      render json: { error: "Not authorized" }, status: :unauthorized
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
    ticket = @event.tickets.create!(
      user: current_user,
      seat_row: params[:seat_row],
      seat_number: params[:seat_number],
      price: params[:price]
    )
    render json: ticket, status: :created
  end

  private

  def current_user
    # Stubbed for now: Replace with real authentication later
    User.find_by(email: request.headers['X-User-Email']) || User.first
  end

  def set_organization
    @organization = Organization.find_by(id: params[:organization_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :date, :location)
  end
end
