class AddUserIdToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :user_id, :integer, null: false, default: 0, after: :id
  end
end
