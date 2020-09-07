class Public::OrdersController < Public::Base
 before_action :authenticate_user!
 before_action :correct_user, only: [:show]
  def index
  	@orders = Order.where(end_user_id: current_end_user.id)
  end

  def show
  	@order = Order.find(params[:id])
  end

  def correct_user
   @order = Order.find(params[:id])
   	if @order.end_user_id != current_end_user.id
      redirect_to orders_path
    end
  end
end
