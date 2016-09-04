class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_name, :string
    add_column :users, :mobile, :string
  end
end
