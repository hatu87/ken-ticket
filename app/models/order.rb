class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items

  def self.checkout(user, ticket_types)
    order = Order.new
    order.user = user

    order.save
    # binding.pry
    if order.valid? && ticket_types.length > 0

      ticket_types.each do |id, quantity|
        type = TicketType.find_by(id: id)
        event = type.event
        # binding.pry
        if event.available?
          current_tickets_count = type.current_tickets_count

          if current_tickets_count + quantity.to_i <= type.max_quantity && quantity.to_i > 0 && quantity.to_i <= 10
            order.order_items << OrderItem.create(quantity: quantity, ticket_type_id: id, price: type.price)
          end
        end
      end

      if order.order_items.count == 0
        order.destroy
        nil
      else
        order
      end

    else
      nil
    end
  end
end
