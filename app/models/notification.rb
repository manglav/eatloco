class Notification < ActiveRecord::Base
  attr_accessible :content, :user_id, :exited_out
  belongs_to :user

  scope :newly_listed, where(exited_out: false)
end
