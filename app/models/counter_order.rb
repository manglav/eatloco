class CounterOrder < ActiveRecord::Base
  attr_accessible :delivery_date, :delivery_type, :desired_price, :g_weight, :notes, :original_order_id, :user_id


  belongs_to :original_order
  belongs_to :user

  scope :expired, joins(:original_order).merge(OriginalOrder.expired)
  scope :in_progress, joins(:original_order).merge(OriginalOrder.in_progress)

  # scope :expired, joins(:original_order).where('expiration_date < ?', Time.now)

  # def self.expired
  #   joins(:original_order).where('expiration_date < ?', Time.now)
  # end

end

