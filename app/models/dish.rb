class Dish < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true, length: { in: 6..30 }
  attr_accessible :name, :photo_ids, :menu_id, :SetNamefromMenu

  belongs_to :user
  belongs_to :menu

  has_many :dish_attachments
  has_many :photos, :through => :dish_attachments, :source => :attachment

  def SetNamefromMenu(menu_id)
    self.name = Menu.find(menu_id).name
  end

end
