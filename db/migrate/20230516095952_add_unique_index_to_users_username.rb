class AddUniqueIndexToUsersUsername < ActiveRecord::Migration[6.1]
  def change
    add_index :users, "LOWER(username)", unique: true
  end
end
