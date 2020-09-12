FactoryBot.define do
  factory :order_item do
    order_id { 1 }
    item_id { 1 }
    quantity { 2 }
    ordering_price { 550 }
    making_status { 0 }
  end
  factory :order_item2, class: OrderItem do
    order_id { 1 }
    item_id { 2 }
    quantity { 3 }
    ordering_price { 660 }
    making_status { 0 }
  end
end