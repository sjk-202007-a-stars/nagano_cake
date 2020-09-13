class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :items, :image_id, :string, null: true, default: nil
  end

  def down
    change_column :items, :image_id, :string, null: false, default: 'no_image'
  end
end
