class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :uploader_id
      t.string :url
      t.string :filename
      t.integer :size
      t.string :filetype

      t.timestamps
    end
  end
end
