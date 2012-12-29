class AddUserIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :user_id, :integer, null: false, default: 0, after: :id
  end
end
