class AddExitedOutToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :exited_out, :boolean, default: false
  end
end
