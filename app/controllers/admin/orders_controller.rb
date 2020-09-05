class Admin::OrdersController < Admin::Base
  def index
  	@orders = Order.all
  	@total_order_quantity = 0
  	@order_items = OrderItem.all
  	@order_items each do |order_item|
  	  @total_order_quantity += order_item.quantity
  	end
  end

  def show
  	@order = Order.find(params[:end_user_id])
  end
end
