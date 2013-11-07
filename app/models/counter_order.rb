class CounterOrder < ActiveRecord::Base
  attr_accessible :delivery_date, :delivery_type, :desired_price, :g_weight, :notes, :original_order_id, :user_id

  belongs_to :original_order
  belongs_to :user

end

