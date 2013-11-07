class AddMenuIdToOriginalOrder < ActiveRecord::Migration
  def change
    add_column :original_orders, :menu_id, :integer
  end
end
