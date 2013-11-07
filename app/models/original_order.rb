class OriginalOrder < ActiveRecord::Base
  attr_accessible :delivery_date, :delivery_type, :desired_price, :expiration_date, :g_weight, :notes, :user_id, :winner_id

  validates :delivery_type, inclusion: { in: %w(delivery pickup neutral), message: "Please pick a valid delivery type."}


  belongs_to :user
  has_many :counter_orders
  belongs_to :menu



end

