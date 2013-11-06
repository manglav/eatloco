class CreateDishAttachments < ActiveRecord::Migration
  def change
    create_table :dish_attachments do |t|
      t.integer :dish_id
      t.integer :attachment_id

      t.timestamps
    end
  end
end
