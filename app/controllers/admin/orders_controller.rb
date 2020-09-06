class Admin::OrdersController < Admin::Base
  def index
  	@orders = Order.all
    
  end

  def show
  	@order = Order.find(params[:id])
  end
  def update
  	@order = Order.find(params[:id])
  	if @order.update(order_params)
  	  redirect_to admin_order(@order)
  	end
  end

  private
  def order_params
  	params.require(:order).permit(:status)
  end
end
