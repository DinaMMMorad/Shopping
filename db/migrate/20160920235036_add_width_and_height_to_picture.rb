class AddWidthAndHeightToPicture < ActiveRecord::Migration
  def change
    add_column :products, :width, :float
    add_column :products, :height, :float
  end
end
