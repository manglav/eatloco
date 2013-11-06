class Dish < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true, length: { in: 6..12 }
  attr_accessible :name, :photo_ids

  belongs_to :user
  has_many :dish_attachments
  has_many :photos, :through => :dish_attachments, :source => :attachment


end
