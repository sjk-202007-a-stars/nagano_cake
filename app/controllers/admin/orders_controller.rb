class Admin::OrdersController < Admin::Base

  def index
   case params[:order_sort]
   when "0"
    # <%= link_to "本日の注文件数", admins_orders_path(order_sort: 0) %>
    @orders = Order.where(created_at: Date.today)
   when "1"
    # <%= link_to "注文一覧", admins_orders_path(order_sort: 1) %>
    @end_user = EndUser.find(params[:end_user_id])
    @orders = @end_user.orders
   else
    @orders = Order.all
   end
  end

  def show
  	@order = Order.find(params[:id])
  end
  def update
  	@order = Order.find(params[:id])
  	if @order.update(order_params)
  	  redirect_to admin_order_path(@order)
  	end
  end

  private
  def order_params
  	params.require(:order).permit(:status)
  end
end
