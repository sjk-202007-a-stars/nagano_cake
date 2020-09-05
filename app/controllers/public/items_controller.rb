class Public::ItemsController < Public::Base
  def index
    @genres = Genre.where(is_active: true)
    item_index
  end

  def show
    @genres = Genre.where(is_active: true)
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def item_index
    if params[:genre_id]
      @items = Item.where(genre_id: params[:genre_id], sales_status: true).page(params[:page]).per(8)
      @genre = Genre.find(params[:genre_id])
    else
      @items = Item.where(sales_status: true).page(params[:page]).per(8)
    end
  end
end
