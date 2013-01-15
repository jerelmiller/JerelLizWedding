class CreateBlog < ActiveRecord::Migration
  def up
    create_table :blogs do |t|
      t.string :title, :default => nil
      t.text :body, :default => nil

      t.timestamps
    end
    add_attachment :blogs, :cover_photo
  end

  def down
    drop_table :blogs
  end
end
