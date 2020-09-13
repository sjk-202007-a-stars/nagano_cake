class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: { 着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3 }

  after_update :change_status
  protected
	def change_status
	  if self.making_status == "製作中"
		  self.order.update(status: 2)
	  elsif self.order.order_items.all?{|order_item|order_item.making_status == "製作完了"}
		self.order.update(status: 3)
	  end
	end
end
