class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false
      t.string :postal_code, null: false
      t.text :address, null: false
      t.string :name, null: false
      t.integer :subtotal_price, null: false
      t.integer :postage, null: false
      t.integer :payment_method, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
