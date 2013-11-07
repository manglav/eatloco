class Order < ActiveRecord::Base
  attr_accessible :delivery_date, :delivery_type, :desired_price, :expiration_date, :g_weight, :notes, :parent_id, :user_id, :winner_id


  #VALIDATIONS LIST

  #delivery type must be one of three options, delivery, pickup, neutral



  #IF A NEW ORDER
  #validate that parent_id is NIL
  #winner id is NIL
  # Now to Decision date must be between 2 and 7 days
  # delivery date must between 12h to 7 days after decision date

  #IF A COUNTER_ORDER
  # validates NOW to decision day is at zer0
  #winner id is NIL

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


  def delivery_datepicker(date_string)
  end

end
