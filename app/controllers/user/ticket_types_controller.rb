class User::TicketTypesController < User::UserApplicationController
  def create
    event = Event.find_by(id: params[:event_id])

    type = TicketType.new(ticket_type_params)
    type.event = event

    if type.save
      flash[:success] = 'Add ticket type successfully'
    else
      flash[:error] = 'Add ticket type unsuccessfully'
    end

    redirect_to edit_user_event_path(event.id)
  end

  private
  def ticket_type_params
    params.require(:ticket_type).permit(:price, :name, :max_quantity)
  end
end
