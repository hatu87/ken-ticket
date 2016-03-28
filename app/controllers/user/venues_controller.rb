class User::VenuesController < ApplicationController
  def new
    @venue = Venue.new
  end

  def create
    venue = Venue.new(venue_params)

    if venue.save
      flash[:success] = 'Create venue successfully'
    else
      flash[:error] = 'Create venue unsuccessfully'
    end

    redirect_to action: :index
  end

  def index
    @venues = Venue.all
  end

  private
  def venue_params
    params.require(:venue).permit(:name, :full_address, :region_id)
  end
end
