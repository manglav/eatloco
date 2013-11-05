class Attachment < ActiveRecord::Base
  attr_accessible :uploader_id, :filename, :size, :filetype, :url

  validates :filename, :size, :filetype, :url, presence: true

  belongs_to :uploader, class_name: "User", foreign_key: :uploader_id
end
