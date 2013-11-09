class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :attachments, foreign_key: :uploader_id

  has_many :dishes

  has_many :original_orders
  has_many :counter_orders

  has_many :bidded_orders, through: :counter_orders, source: :original_order
  has_many :notifications

  def elgible_orders
    OriginalOrder.includes(:user)
      .in_progress
      .where(:menu_id => self.dishes.pluck(:menu_id))
      .where("user_id != ?", self.id)
      .where("id not in (?)", self.bidded_order_ids.blank? ? '' : self.bidded_order_ids)
    ## add condition that originalorder id NOT in user.counter_orders(array)
  end

  def successful_orders
    self.original_orders.includes(:user).expired.has_winner
  end

  def failed_orders
    self.original_orders.includes(:user).expired.no_winner
  end

  def won_orders
    self.counter_orders.includes(:original_order => :user).where(:id => self.bidded_orders.expired.pluck(:winner_id))
  end

  def lost_orders
    self.counter_orders.includes(:original_order => :user).where("id not in (?)", self.bidded_order_ids.blank? ? '' : self.bidded_orders.expired.pluck(:winner_id))
  end



end
