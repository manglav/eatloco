class Menu < ActiveRecord::Base
  attr_accessible :name, :string
  validates :name, presence: true, uniqueness: true

  has_many :dishes

end
