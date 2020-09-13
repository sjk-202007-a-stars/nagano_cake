class Item < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: {maximum: 30}
  validates :introduction, presence: true, length: {maximum: 100}
  validates :price, presence: true, numericality: {only_integer: true}
  validates :sales_status, inclusion: {in: [true, false]}

  belongs_to :genre
  has_many :cart_items
  attachment :image
  has_many :order_items
  has_many :orders, through: :order_items

  def price_with_tax
    (BigDecimal(self.price) * BigDecimal("1.1")).ceil.to_s(:delimited)
  end

  def is_on_sale?
    if self.sales_status == true
      "販売中"
    elsif self.sales_status == false
      "売切れ"
    end
  end
end
