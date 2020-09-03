class RenameCUstomerIdToCartItems < ActiveRecord::Migration[5.2]
  def change
  	rename_column :cart_items, :customer_id, :end_user_id
  end
end
