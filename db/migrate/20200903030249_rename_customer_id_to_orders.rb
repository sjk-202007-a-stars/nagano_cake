class RenameCustomerIdToOrders < ActiveRecord::Migration[5.2]
  def change
  	rename_column :orders, :customer_id, :end_user_id
  end
end
