class AddOsVersionToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :os_version, :integer
  end
end
