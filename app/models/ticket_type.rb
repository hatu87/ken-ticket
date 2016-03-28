class TicketType < ActiveRecord::Base
  belongs_to :event
  has_many :order_items

  def current_tickets_count
    order_items.sum(:quantity)
  end

end
