class Admin::OrderItemsController < Admin::Base

  def update
  	@order = Order.find(params[:order_id])
  	@order_item = @order.order_item.find(params[:item_id])
    @order_item.update(order_item_params)
    if @order.update(order_params)
  	    redirect_to admin_order_path(@order)
  	end
  end

  private
   def order_item_params
  	params.require(:order_item).permit(:making_status)
   end
end
