class User::EventsController < User::UserApplicationController
  def index
    @events = Event.owned_by(current_user.id)
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    event.owner = current_user

    if event.save
      flash[:success] = 'Event created successfully'
      redirect_to action: :edit, id: event.id

    else
      flash[:error] = 'Event created unsuccessfully'
      redirect_to action: :new
    end
  end

  def edit
    @event = Event.find_by(id: params[:id])
  end

  def update
  end

  def publish
    event = Event.find_by(id: params[:id])

    event.published = true
    # binding.pry
    if event.save
      flash[:success] = 'Publish successfully'
      redirect_to action: :edit, id: event.id
    else
      flash[:error] = 'Publish unsuccessfully'
      redirect_to action: :edit, id: event.id
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :starts_at, :ends_at, :hero_image_url,
      :extended_html_description, :category_id, :venue_id)
  end
end
