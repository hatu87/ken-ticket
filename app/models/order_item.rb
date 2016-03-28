class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :ticket_type
end
