class Public::CartItemsController < Public::Base
  def index
    @cart_items = CartItem.where(end_user_id: current_end_user.id)
    @total_price = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      redirect_to cart_items_path
    else
      flash[:alert] = "Please select a number"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.end_user_id == current_end_user.id
      cart_item.destroy
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy_all
    cart_items = CartItem.where(end_user_id: current_end_user.id)
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :end_user_id, :quantity)
  end
end
