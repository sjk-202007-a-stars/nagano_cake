class Admin::OrderItemsController < Admin::Base

  def update
  	@order = Order.find(params[:order_id])
  	@order_item = @order.order_item.find(params[:id])
    @order_item.update(order_item_params)

  end

  private
   def order_item_params
  	params.require(:order_item).permit(:making_status)
   end
end
