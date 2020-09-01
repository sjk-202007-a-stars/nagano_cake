class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, null: false
      t.references :item, null: false
      t.integer :quantity, null: false
      t.integer :ordering_price, null: false
      t.integer :making_status, null: false, default: 0

      t.timestamps
    end
  end
end
