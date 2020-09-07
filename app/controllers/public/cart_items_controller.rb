class Public::CartItemsController < Public::Base
  def index
    @cart_items = CartItem.where(end_user_id: current_end_user.id)
    @subtotal_price = 0 #ビューで使う変数の初期化
  end

  def create
    #同じ商品がカートに入っているか検索
    existing_cart_item = CartItem.find_by(end_user_id: current_end_user.id, item_id: cart_item_params[:item_id])

    @cart_item = CartItem.new(cart_item_params)
    if existing_cart_item #同じ商品がカートに入っていたら個数を上書きする
      existing_cart_item.quantity = @cart_item.quantity
      existing_cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save
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
