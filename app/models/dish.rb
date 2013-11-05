class Dish < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true, length: { in: 6..12 }
  attr_accessible :name

end
