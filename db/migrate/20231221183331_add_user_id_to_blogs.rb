class AddUserIdToBlogs < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :user_id, :integer
    add_index :blogs, :user_id
    add_foreign_key :blogs, :users, column: :user_id
  end
end