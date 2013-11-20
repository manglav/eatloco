class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :current_sign_in_ip, :latitude, :longitude

  # Geocoder options
  geocoded_by :current_sign_in_ip   # can also be an IP address

  after_validation :geocode, if: :current_sign_in_ip_changed?

  has_many :attachments, foreign_key: :uploader_id

  has_many :dishes

  has_many :original_orders
  has_many :counter_orders

  has_many :bidded_orders, through: :counter_orders, source: :original_order
  has_many :notifications

  def elgible_orders
    OriginalOrder.includes(:user)
      .in_progress # only in progress orders
      .where(:menu_id => self.dishes.pluck(:menu_id)) # user has to have the menu id
      .where("user_id != ?", self.id) # user can't bid on their own orders
      .exclude(:id, self.bidded_order_ids) # user can't have already bid on the order
    ## add condition that originalorder id NOT in user.counter_orders(array)
  end

  def successful_orders
    self.original_orders.includes(:user).expired.not_delivered.has_winner
  end

  def failed_orders
    self.original_orders.includes(:user).expired.no_winner
  end

  def won_orders
    self.counter_orders.includes(:original_order).expired.where("counter_orders.id = original_orders.winner_id")
  end

  def lost_orders # the counter orders that belong to original orders that have expired and have not picked you as a winner(either picked someone else, or no one)
    self.counter_orders.includes(:original_order).expired.where("counter_orders.id != original_orders.winner_id OR original_orders.winner_id IS NULL")
    #counter orders ----> original orders
=begin
FIND BY SQL
SELECT counter_orders.*
FROM counter_orders
INNER JOIN original_orders
ON original_order_id = original_orders.id
WHERE counter_orders.id <> original_orders.winner_id
OR original_orders.winner_id IS NULL






SELECT counter_orders.*
FROM counter_orders
INNER JOIN original_orders
ON (original_order_id = original_order.id)
WHERE counter_order.id IS NOT original_order.winner_id

=end
  end

  def notify!(options)
    if options[:positive] && options[:order].is_a?(OriginalOrder)
      content = "Your order for #{options[:order].menu.name} was fulfilled!"
    elsif options[:positive] && options[:order].is_a?(CounterOrder)
      content = "Your counter order won for #{options[:order].menu.name}!"
    elsif !options[:positive] && options[:order].is_a?(OriginalOrder) && options[:any_counter_orders]
      content = "You did not select a winner for #{options[:order].menu.name}."
    elsif !options[:positive] && options[:order].is_a?(OriginalOrder) && !options[:any_counter_orders]
      content = "Your order for #{options[:order].menu.name} had no bids."
    elsif !options[:positive] && options[:order].is_a?(CounterOrder) && options[:any_counter_orders]
      content = "Your counter-order was not selected for #{options[:order].menu.name}."
    elsif !options[:positive] && options[:order].is_a?(CounterOrder) && !options[:any_counter_orders]
      content = "The auction starter did not select a winner for #{options[:order].menu.name}."
    end
    options[:user].notifications.create(content: content, exited_out: false)
  end

end
