class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_index :users, :username, unique: true, name: "username_index"
    #Ex:- add_index("admin_users", "username")
  end
end
