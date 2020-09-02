class Public::ItemsController < Public::Base
  def index
    @genres = Genre.all
    item_index
  end

  def show
  end

  private

  def item_index
    if params[:genre_id]
      @items = Item.where(genre_id: params[:genre_id]).page(params[:page]).per(8)
      @genre = Genre.find(params[:genre_id])
    else
      @items = Item.page(params[:page]).per(8)
    end
  end
end
