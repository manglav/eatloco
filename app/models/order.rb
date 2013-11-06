class Order < ActiveRecord::Base
  attr_accessible :delivery_date, :delivery_type, :desired_price, :expiration_date, :g_weight, :notes, :parent_id, :user_id, :winner_id

  belongs_to :user

  belongs_to(
    :parent_order,
    class_name: "Order",
    foreign_key: :parent_id,
    primary_key: :id
    )

  has_many(
  :counter_orders,
  class_name: "Order",
  foreign_key: :parent_id,
  primary_key: :id
  )

  belongs_to(
  :winning_order,
  class_name: "Order",
  foreign_key: :winner_id,
  primary_key: :id
  )
end
