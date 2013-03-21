class CreateRsvpTable < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :name, default: nil
      t.integer :attending, default: 0, null: false

      t.timestamps
    end
  end
end
