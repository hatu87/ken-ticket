module User::EventsHelper
  def class_for_publish_button(event)
    if event.published || event.ticket_types.count == 0
      'disabled'
    end
  end

end
