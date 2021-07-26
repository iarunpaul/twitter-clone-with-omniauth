class RemoveUniqueIndicesFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, name: "index_users_on_email"
    remove_index :users, name: "username_index"
  end
end
