class Attachment < ActiveRecord::Base
  attr_accessible :uploader_id, :filename, :size, :filetype, :url

  validates :filename, :size, :filetype, :url, presence: true

  belongs_to :uploader, class_name: "User", foreign_key: :uploader_id

  has_one :dish_attachments

  has_one :dish, :through => :dish_attachments, :source => :dish

end
