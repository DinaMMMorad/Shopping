class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :os_name
      t.string :reg_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
