class OriginalOrder < ActiveRecord::Base
  attr_accessible :delivery_date, :delivery_type, :desired_price, :expiration_date, :g_weight, :notes, :user_id, :winner_id

  belongs_to :user
  has_many :counter_orders

end

