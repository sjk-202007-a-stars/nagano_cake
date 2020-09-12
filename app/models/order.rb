class Order < ApplicationRecord
  belongs_to :end_user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: {
    入金待ち:0,入金確認:1,製作中:2,発送準備中:3,発送済み:4
  }

  def total_count
  	@total_order_quantity = 0
  	@order_items = self.order_items
  	@order_items.each do |order_item|
  	  @total_order_quantity += order_item.quantity
    end
  	return @total_order_quantity
  end

  POSTAGE = 800
  # 送料定義

  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }
  
  after_update :change_status
  protected
  def change_status
    if self.status == "入金確認"
      self.order_items.update_all(making_status: 1)
    end
  end
end
