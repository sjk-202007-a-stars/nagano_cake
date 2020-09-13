class ChangeColumnToDefaultNil < ActiveRecord::Migration[5.2]
  def up
    change_column :items, :sales_status, :boolean, default: nil
  end

  def down
    change_column :items, :sales_status, :boolean, default: false
  end
end
