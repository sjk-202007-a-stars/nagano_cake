class AddColumnToEndUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :end_users, :family_name, :string, default: "", null: false
    add_column :end_users, :first_name, :string, default: "", null: false
    add_column :end_users, :family_name_kana, :string, default: "", null: false
    add_column :end_users, :first_name_kana, :string, default: "", null: false
    add_column :end_users, :postal_code, :string, default: "", null: false
    add_column :end_users, :phone_number, :string, default: "", null: false
    add_column :end_users, :address, :text, default: "", null: false
    add_column :end_users, :is_deleted, :boolean, null: false, default: false
  end
end
