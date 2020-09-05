class Public::OrdersController < Public::Base
  def index
  	@orders = current_end_user.orders
  end

  def show
  	@order = Order.find(params[:id])
  	end
  end
end
