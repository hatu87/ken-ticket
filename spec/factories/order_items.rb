FactoryGirl.define do
  factory :order_item do
    order_id 1
    ticket_type_id 1
    quantity 1
    price "9.99"
  end
end
