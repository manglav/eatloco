class Attachment < ActiveRecord::Base
  attr_accessible :uploader_id, :filename, :size, :filetype, :url

  validates :filename, :filetype, :url, presence: true

  belongs_to :uploader, class_name: "User", foreign_key: :uploader_id

  has_one :dish_attachment

  has_one :parent_dish, :through => :dish_attachment, :source => :dish

end
