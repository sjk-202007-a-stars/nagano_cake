class Order < ApplicationRecord
  belongs_to :end_user
  has_many :order_items

  POSTAGE = 800
  # 送料定義

  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }
end
