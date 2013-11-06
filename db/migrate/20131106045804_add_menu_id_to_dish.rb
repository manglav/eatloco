class AddMenuIdToDish < ActiveRecord::Migration
  def change
    add_column :dishes, :menu_id, :integer
  end
end
