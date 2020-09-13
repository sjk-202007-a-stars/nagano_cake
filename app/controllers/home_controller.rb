class HomeController < ApplicationController
  def top
  	@genres = Genre.where(is_active: true)
    #注文のあった商品を売上金額順に表示
    @items = Item.find(OrderItem.group(:item_id).order("sum(ordering_price) desc").limit(4).pluck(:item_id))
    #テスト対策 まだどの商品も売れてない場合はID順で4つ表示
    if @items.count == 0
      @items = Item.limit(4)
    end
  end

  def about
  end
end
