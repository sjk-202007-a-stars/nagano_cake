class Admin::SearchesController < Admin::Base
  def search
    @range = params[:range]
    word = params[:word]
      if @range == '1'
         @end_users = EndUser.where("family_name LIKE? or first_name LIKE?","%#{word}%", "%#{word}%")
      else
      	 @items = Item.where("name LIKE?","%#{word}%")
      end
  end
end


