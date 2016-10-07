class AddImageToNotification < ActiveRecord::Migration
  def up
    add_attachment :notifications, :picture
  end

  def down
    remove_attachment :notifications, :picture
  end
end
