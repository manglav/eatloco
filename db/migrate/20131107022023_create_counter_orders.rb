class CreateCounterOrders < ActiveRecord::Migration
  def change
    create_table :counter_orders do |t|
      t.integer :user_id
      t.integer :original_order_id
      t.integer :g_weight
      t.integer :desired_price
      t.datetime :expiration_date
      t.datetime :delivery_date
      t.text :notes
      t.string :delivery_type

      t.timestamps
    end
  end
end
