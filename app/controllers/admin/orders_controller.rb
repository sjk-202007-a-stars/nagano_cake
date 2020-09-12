class Admin::OrdersController < Admin::Base

  def index
    case params[:order_sort]
    when "1"
      @end_user = EndUser.find(params[:end_user_id])
      @orders = @end_user.orders
    when "2"
      @orders = Order.where("created_at >= ?", Time.zone.now.beginning_of_day)
     else
      @orders = Order.all
    end
  end

  def show
    @order = Order.find(params[:id])
  end
  def update
  	@order = Order.find(params[:id])
  	@order.update(order_params)
      redirect_back(fallback_location: root_path)
  end

  private
  def order_params
  	params.require(:order).permit(:status)
  end
end
