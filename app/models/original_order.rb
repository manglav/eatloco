class OriginalOrder < ActiveRecord::Base
  attr_accessible :delivery_date, :delivery_type, :desired_price, :expiration_date, :g_weight, :notes, :user_id, :winner_id

  validates :delivery_type, inclusion: { in: %w(delivery pickup neutral), message: "Please pick a valid delivery type."}

  # validate :winner_is_a_counter_order
  scope :in_progress, where("expiration_date > ?", Time.now)
  scope :expired, where("expiration_date < ?", Time.now)
  scope :has_winner, where("winner_id IS NOT NULL")
  scope :no_winner, where(winner_id: nil)

  belongs_to :user
  has_many :counter_orders
  belongs_to :menu

  belongs_to :winner, class_name: "CounterOrder", foreign_key: :winner_id

  def lost_orders
    self.counter_orders.where("id NOT IN (?)", self.winner_id.blank? ? '' : self.winner_id)
  end

end
