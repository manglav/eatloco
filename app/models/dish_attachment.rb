class DishAttachment < ActiveRecord::Base
  attr_accessible :attachment_id, :dish_id

  validates :attachment_id, :attachment_id, presence: true

  belongs_to :attachment
  belongs_to :dish

end
