class SeatsController < ApplicationController
  before_action :set_event

  def index
    render json: @event.seats
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end