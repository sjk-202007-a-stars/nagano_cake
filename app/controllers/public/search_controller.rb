class Public::SearchController < Public::Base
  def search
    search = params[:search_method]
    word = params[:search_method]
    @items = Item.search(method, word)
  end
end
