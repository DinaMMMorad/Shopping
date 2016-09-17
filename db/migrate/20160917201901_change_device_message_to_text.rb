class ChangeDeviceMessageToText < ActiveRecord::Migration
  def self.up
    change_table :notifications do |t|
      t.change :message, :text
    end
  end
  def self.down
    change_table :notifications do |t|
      t.change :message, :string
    end
  end
end
