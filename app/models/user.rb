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

  def elgible_orders
    OriginalOrder.where(:menu_id => self.dishes.pluck(:menu_id))
    .where("expiration_date > ?", Time.now)
    .where("user_id != ?", self.id)
    .where("id != ?", self.bidded_order_ids)
    ## add condition that originalorder id NOT in user.counter_orders(array)
  end

  def current_counter_orders

  end

end
