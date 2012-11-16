class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file_path, :default => nil
      t.string :title, :default => nil

      t.timestamps
    end
  end
end
