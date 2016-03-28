class TicketsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:new]
  def new
    @event = Event.find(params[:event_id])
    @venues = Venue.all
    @categories = Category.all
  end


end
