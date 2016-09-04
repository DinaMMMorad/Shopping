class AddCategoryToProduct < ActiveRecord::Migration
  def change
    add_column :products, :categort, :integer
  end
end
