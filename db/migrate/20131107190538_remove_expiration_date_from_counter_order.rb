class RemoveExpirationDateFromCounterOrder < ActiveRecord::Migration
  def up
    remove_column :counter_orders, :expiration_date
  end

  def down
    add_column :counter_orders, :expiration_date, :datetime
  end
end
