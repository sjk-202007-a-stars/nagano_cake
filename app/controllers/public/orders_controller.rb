class Public::OrdersController < Public::Base
  before_action :authenticate_end_user!



  def new
    @order = Order.new
  end

  # def index
  # end

  # def show
  # end

  def create
  	if current_end_user.cart_items.exists?
      @order = Order.new(order_params)
      @order.end_user_id = current_end_user.id
      @order.postage = Order::POSTAGE
      # Orederモデルで定義

      # 住所のラジオボタン選択に応じて引数を調整
      @add = params[:order][:add].to_i
      case @add
        when 1
          @order.postal_code = current_end_user.postal_code
          @order.address = current_end_user.address
          @order.name = full_name(current_end_user)
        when 2
          @order.postal_code = params[:order][:postal_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
        when 3
          @order.postal_code = params[:order][:postal_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
      end
      @order.save

       # send_to_addressで住所モデル検索、該当データなければ新規作成
      if ShippingAddress.find_by(address: @order.address).nil?
        @address = ShippingAddress.new
        @address.postal_code = @order.postal_code
        @address.address = @order.address
        @address.name = @order.name
        @address.end_user_id = current_end_user.id
        @address.save
      end

      # cart_itemsの内容をorder_itemsに新規登録
      current_end_user.cart_items.each do |cart_item|
        order_item = @order.order_items.build
        order_item.order_id = @order.id
        order_item.item_id = cart_item.item_id
        order_item.quantity = cart_item.quantity
        order_item.ordering_price = cart_item.sub_total
        order_item.save
        cart_item.destroy #order_itemに情報を移したらcart_itemは消去
      end
      render :thanks
    end
  end

  def confirm
    @order = Order.new
    @cart_items = current_end_user.cart_items
    @order.payment_method = params[:order][:payment_method].to_i
    # 住所のラジオボタン選択に応じて引数を調整
    @add = params[:order][:add].to_i
    case @add
      when 1
        @order.postal_code = current_end_user.postal_code
        @order.address = current_end_user.address
        @order.name = current_end_user.family_name + current_end_user.first_name
      when 2
        @sta = params[:order][:address].to_i
        @address = ShippingAddress.find(@sta)
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      when 3
        @order.postal_code = params[:order][:new_add][:postal_code]
        @order.address = params[:order][:new_add][:address]
        @order.name = params[:order][:new_add][:name]
    end
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(
      :created_at, :address, :name, :status, :payment_method, :postal_code, :postage, :subtotal_price,
      order_items_attributes: [:order_id, :item_id, :quantity, :ordering_price, :making_status]
      )
  end

end
