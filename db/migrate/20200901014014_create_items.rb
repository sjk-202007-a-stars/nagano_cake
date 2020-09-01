class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :genre, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.string :image_id, null: false, default: 'no_image'
      t.boolean :sales_status, null: false, default: false
      t.timestamps
    end
  end
end
