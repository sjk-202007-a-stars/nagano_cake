class CartItem < ApplicationRecord
  validates :quantity, numericality: {only_integer: true}

  belongs_to :end_user
  belongs_to :item

  def sub_total
    BigDecimal(self.item.price) * BigDecimal("1.1") * BigDecimal(self.quantity)
  end
end
