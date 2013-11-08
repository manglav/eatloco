class Menu < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, uniqueness: true

  has_many :dishes
  has_many :original_orders

end