class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :parent_id
      t.integer :winner_id
      t.integer :g_weight
      t.integer :desired_price
      t.datetime :delivery_date
      t.datetime :expiration_date
      t.text :notes
      t.string :delivery_type

      t.timestamps
    end
  end
end
