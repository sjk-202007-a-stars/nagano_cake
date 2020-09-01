class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.references :customer, null: false
      t.string :postal_code, null: false
      t.text :address, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
