class HomeController < ApplicationController
  def top
  	@genres = Genre.where(is_active: true)
  	@items = Item.limit(4)
  end

  def about
  end
end
