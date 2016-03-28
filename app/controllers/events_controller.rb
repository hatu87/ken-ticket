class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  # skip_before_action :require_no_authentication, only: [:index, :show]
  def index
    @events = Event.search(params[:search])
  end

  def show
    @event = Event.find(params[:id])
  end




end
# t.datetime "starts_at"
#   t.datetime "ends_at"
#   t.integer  "venue_id"
#   t.string   "hero_image_url"
#   t.text     "extended_html_description"
#   t.integer  "category_id"
#   t.string   "name"
