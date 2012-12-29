class AddPaperclipAttachmentToImages < ActiveRecord::Migration
  def up
    remove_column :images, :file_path
    add_attachment :images, :image
  end

  def down
    remove_attachment :images, :image
    add_column :images, :file_path, :string, :default => nil
  end
end
